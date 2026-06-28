import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:medalize_mb/core/widgets/gradient_avatar.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

enum _DoctorSort { relevance, rating, priceLow, name }

const _kSpecializations = [
  'general_practice',
  'cardiology',
  'dermatology',
  'neurology',
  'orthopedics',
  'pediatrics',
  'psychiatry',
  'gynecology',
  'urology',
  'ophthalmology',
  'ent',
];

String _specLabel(BuildContext context, String spec) {
  final s = context.t.doctorSearch.spec;
  return switch (spec) {
    'general_practice' => s.general,
    'cardiology' => s.cardiology,
    'dermatology' => s.dermatology,
    'neurology' => s.neurology,
    'orthopedics' => s.orthopedics,
    'pediatrics' => s.pediatrics,
    'psychiatry' => s.psychiatry,
    'gynecology' => s.gynecology,
    'urology' => s.urology,
    'ophthalmology' => s.ophthalmology,
    'ent' => s.ent,
    _ => spec,
  };
}

class DoctorSearchScreen extends ConsumerStatefulWidget {
  const DoctorSearchScreen({super.key});

  @override
  ConsumerState<DoctorSearchScreen> createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends ConsumerState<DoctorSearchScreen> {
  final _nameController = TextEditingController();
  String? _selectedSpecialization;
  String? _cityInput;
  int? _minRating;
  _DoctorSort _sort = _DoctorSort.relevance;
  SearchParams _params = const SearchParams();

  /// Client-side ordering of the backend result list. "relevance" keeps the
  /// order the backend returned.
  List<DoctorModel> _sortDoctors(List<DoctorModel> list) {
    if (_sort == _DoctorSort.relevance) return list;
    final out = [...list];
    switch (_sort) {
      case _DoctorSort.relevance:
        break;
      case _DoctorSort.rating:
        out.sort((a, b) =>
            (b.averageRating ?? -1).compareTo(a.averageRating ?? -1));
      case _DoctorSort.priceLow:
        out.sort((a, b) => _fee(a).compareTo(_fee(b)));
      case _DoctorSort.name:
        out.sort((a, b) =>
            a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));
    }
    return out;
  }

  // Doctors without a fee sort last.
  double _fee(DoctorModel d) =>
      double.tryParse(d.consultationFee ?? '') ?? double.infinity;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  SearchParams _buildParams() => SearchParams(
        name: _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
        city: (_cityInput?.trim().isEmpty ?? true) ? null : _cityInput?.trim(),
        specialization: _selectedSpecialization,
        minRating: _minRating,
      );

  void _search() => setState(() => _params = _buildParams());

  void _selectSpec(String? spec) {
    setState(() {
      _selectedSpecialization = spec == _selectedSpecialization ? null : spec;
      _params = _buildParams();
    });
  }

  void _selectRating(int? rating) {
    setState(() {
      _minRating = rating == _minRating ? null : rating;
      _params = _buildParams();
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(doctorSearchProvider(_params));

    return Scaffold(
      appBar: AppBar(title: Text(context.t.doctorSearch.title)),
      body: ResponsiveBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.sm + 4, AppSpacing.md, 0),
              child: Column(
                children: [
                  _SearchBar(
                    controller: _nameController,
                    onSearch: _search,
                    onClear: () {
                      _nameController.clear();
                      _search();
                    },
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: context.t.doctorSearch.city,
                            prefixIcon: const Icon(Icons.location_on_outlined,
                                size: 20),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                          onChanged: (v) => _cityInput = v,
                          onSubmitted: (_) => _search(),
                        ),
                      ),
                      const Gap(10),
                      FilledButton(
                        onPressed: _search,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(0, 48),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        child: Text(context.t.doctorSearch.search),
                      ),
                    ],
                  ),
                  const Gap(12),
                  _SpecChips(
                    selected: _selectedSpecialization,
                    onSelect: _selectSpec,
                  ),
                  const Gap(8),
                  _RatingChips(
                    selected: _minRating,
                    onSelect: _selectRating,
                  ),
                ],
              ),
            ),
            const Gap(4),
            Expanded(
              child: results.when(
                loading: () => const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
                  child: Column(
                    children: [
                      ShimmerSkeleton(height: 88),
                      ShimmerSkeleton(height: 88),
                      ShimmerSkeleton(height: 88),
                      ShimmerSkeleton(height: 88),
                    ],
                  ),
                ),
                error: (_, _) => RefreshableView(
                  onRefresh: () async => ref.invalidate(doctorSearchProvider),
                  child: EmptyState(
                    icon: Icons.cloud_off_outlined,
                    title: context.t.common.somethingWrong,
                    subtitle: context.t.doctorSearch.couldNotLoadDoctors,
                    actionLabel: context.t.common.retry,
                    onAction: () => ref.invalidate(doctorSearchProvider),
                  ),
                ),
                data: (doctors) {
                  if (doctors.isEmpty) {
                    return RefreshableView(
                      onRefresh: () async =>
                          ref.invalidate(doctorSearchProvider),
                      child: EmptyState(
                        icon: Icons.person_search_outlined,
                        title: context.t.doctorSearch.noDoctorsFound,
                        subtitle: context.t.doctorSearch.adjustSearch,
                      ),
                    );
                  }
                  final sorted = _sortDoctors(doctors);
                  return Column(
                    children: [
                      _SortBar(
                        value: _sort,
                        onChanged: (v) => setState(() => _sort = v),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async =>
                              ref.invalidate(doctorSearchProvider),
                          color: AppColors.primary,
                          child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                                AppSpacing.md, 4, AppSpacing.md, AppSpacing.md),
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            itemCount: sorted.length,
                            itemBuilder: (_, i) => AnimatedEntrance(
                              index: i,
                              slideY: 0,
                              slideX: 0.05,
                              child: _DoctorCard(doctor: sorted[i]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (_, value, _) => TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: context.t.doctorSearch.searchByName,
          prefixIcon:
              Icon(Icons.search_rounded, color: context.colors.textSecondary),
          suffixIcon: value.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: onClear,
                )
              : null,
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => onSearch(),
      ),
    );
  }
}

class _SpecChips extends StatelessWidget {
  const _SpecChips({required this.selected, required this.onSelect});

  final String? selected;
  final void Function(String?) onSelect;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _kSpecializations.length,
        separatorBuilder: (_, _) => const Gap(8),
        itemBuilder: (_, i) {
          final spec = _kSpecializations[i];
          final label = _specLabel(context, spec);
          final isSelected = selected == spec;
          return FilterChip(
            label: Text(label),
            selected: isSelected,
            onSelected: (_) => onSelect(spec),
            selectedColor: c.primarySurface,
            checkmarkColor: c.primaryText,
            labelStyle: TextStyle(
              color: isSelected ? c.primaryText : c.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 13,
            ),
            side: BorderSide(
              color: isSelected ? AppColors.primary : c.border,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }
}

class _DoctorCard extends ConsumerWidget {
  const _DoctorCard({required this.doctor});
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final initials =
        doctor.firstName.isNotEmpty ? doctor.firstName[0].toUpperCase() : 'D';
    final nextSlot = ref.watch(nextAvailableDateProvider(doctor.id));

    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/patient/doctor-detail/${doctor.id}', extra: doctor);
      },
      child: Row(
        children: [
          Hero(
            tag: 'doctor-avatar-${doctor.id}',
            child: doctor.avatarUrl != null
                ? CachedNetworkImage(
                    imageUrl: doctor.avatarUrl!,
                    imageBuilder: (ctx, imageProvider) => CircleAvatar(
                      radius: 26,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (ctx, _) => GradientAvatar(initials: initials, size: 52),
                    errorWidget: (ctx, url, _) => GradientAvatar(initials: initials, size: 52),
                  )
                : GradientAvatar(initials: initials, size: 52),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.fullName,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(3),
                Row(
                  children: [
                    Icon(Icons.medical_services_outlined,
                        size: 13, color: c.primaryText),
                    const Gap(4),
                    Expanded(
                      child: Text(
                        doctor.specializationDisplay,
                        style: TextStyle(
                            fontSize: 13,
                            color: c.primaryText,
                            fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (doctor.primaryWorkplaceCity != null) ...[
                  const Gap(2),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 13, color: c.textSecondary),
                      const Gap(3),
                      Text(
                        doctor.primaryWorkplaceCity!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
                if (doctor.averageRating != null) ...[
                  const Gap(2),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, size: 13, color: Colors.amber.shade600),
                      const Gap(3),
                      Text(
                        '${doctor.averageRating!.toStringAsFixed(1)} (${doctor.reviewCount})',
                        style: TextStyle(fontSize: 11, color: c.textSecondary),
                      ),
                    ],
                  ),
                ],
                const Gap(4),
                nextSlot.when(
                  loading: () => const SizedBox(
                    height: 12,
                    width: 80,
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                  error: (_, _) => const SizedBox.shrink(),
                  data: (date) => date == null
                      ? Text(
                          context.t.doctorSearch.noAvailability,
                          style: TextStyle(
                              fontSize: 11, color: c.textSecondary),
                        )
                      : Row(
                          children: [
                            Icon(Icons.event_available_outlined,
                                size: 12, color: c.primaryText),
                            const Gap(3),
                            Text(
                              _formatNextDate(context, date),
                              style: TextStyle(
                                fontSize: 11,
                                color: c.primaryText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: c.primarySurface,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(Icons.chevron_right, color: c.primaryText, size: 20),
          ),
        ],
      ),
    );
  }

  String _formatNextDate(BuildContext context, DateTime date) {
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));
    if (date.year == today.year && date.month == today.month && date.day == today.day) {
      return context.t.doctorSearch.availableToday;
    }
    if (date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day) {
      return context.t.doctorSearch.availableTomorrow;
    }
    return context.t.doctorSearch.availableOn(date: DateFormat('d MMM').format(date));
  }
}

String _sortLabel(BuildContext context, _DoctorSort s) {
  final t = context.t.doctorSearch;
  return switch (s) {
    _DoctorSort.relevance => t.sortDefault,
    _DoctorSort.rating => t.sortRating,
    _DoctorSort.priceLow => t.sortPriceLow,
    _DoctorSort.name => t.sortName,
  };
}

class _SortBar extends StatelessWidget {
  const _SortBar({required this.value, required this.onChanged});

  final _DoctorSort value;
  final ValueChanged<_DoctorSort> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 6, AppSpacing.md, 0),
      child: Row(
        children: [
          Text(
            context.t.doctorSearch.sortBy,
            style: TextStyle(fontSize: 13, color: c.textSecondary),
          ),
          const Spacer(),
          Icon(Icons.swap_vert_rounded, size: 16, color: c.textSecondary),
          const Gap(2),
          DropdownButtonHideUnderline(
            child: DropdownButton<_DoctorSort>(
              value: value,
              isDense: true,
              borderRadius: BorderRadius.circular(AppRadius.md),
              icon: Icon(Icons.arrow_drop_down, color: c.textSecondary),
              style: TextStyle(
                fontSize: 13,
                color: c.primaryText,
                fontWeight: FontWeight.w600,
              ),
              items: [
                for (final s in _DoctorSort.values)
                  DropdownMenuItem(
                    value: s,
                    child: Text(_sortLabel(context, s)),
                  ),
              ],
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingChips extends StatelessWidget {
  const _RatingChips({required this.selected, required this.onSelect});

  final int? selected;
  final void Function(int?) onSelect;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, _) => const Gap(8),
        itemBuilder: (_, i) {
          final rating = i + 2;
          final isSelected = selected == rating;
          return FilterChip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded,
                    size: 13,
                    color: isSelected ? c.primaryText : c.textSecondary),
                const Gap(3),
                Text('$rating+'),
              ],
            ),
            selected: isSelected,
            onSelected: (_) => onSelect(rating),
            selectedColor: c.primarySurface,
            checkmarkColor: c.primaryText,
            labelStyle: TextStyle(
              color: isSelected ? c.primaryText : c.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 13,
            ),
            side: BorderSide(
              color: isSelected ? AppColors.primary : c.border,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }
}
