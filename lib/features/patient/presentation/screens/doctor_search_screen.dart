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
import 'package:medalize_mb/core/widgets/gradient_avatar.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';

const _kSpecializations = [
  'general_practitioner',
  'cardiologist',
  'dermatologist',
  'neurologist',
  'orthopedist',
  'pediatrician',
];

const _kSpecLabels = {
  'general_practitioner': 'General',
  'cardiologist': 'Cardiology',
  'dermatologist': 'Dermatology',
  'neurologist': 'Neurology',
  'orthopedist': 'Orthopedics',
  'pediatrician': 'Pediatrics',
};

class DoctorSearchScreen extends ConsumerStatefulWidget {
  const DoctorSearchScreen({super.key});

  @override
  ConsumerState<DoctorSearchScreen> createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends ConsumerState<DoctorSearchScreen> {
  final _nameController = TextEditingController();
  String? _selectedSpecialization;
  String? _cityInput;
  SearchParams _params = const SearchParams();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _search() {
    setState(() {
      _params = SearchParams(
        name: _nameController.text.trim().isEmpty
            ? null
            : _nameController.text.trim(),
        city: (_cityInput?.trim().isEmpty ?? true) ? null : _cityInput?.trim(),
        specialization: _selectedSpecialization,
      );
    });
  }

  void _selectSpec(String? spec) {
    setState(() {
      _selectedSpecialization = spec == _selectedSpecialization ? null : spec;
      _params = SearchParams(
        name: _nameController.text.trim().isEmpty
            ? null
            : _nameController.text.trim(),
        city: (_cityInput?.trim().isEmpty ?? true) ? null : _cityInput?.trim(),
        specialization: _selectedSpecialization,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(doctorSearchProvider(_params));

    return Scaffold(
      appBar: AppBar(title: const Text('Find a Doctor')),
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
                          decoration: const InputDecoration(
                            hintText: 'City',
                            prefixIcon:
                                Icon(Icons.location_on_outlined, size: 20),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
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
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                  const Gap(12),
                  _SpecChips(
                    selected: _selectedSpecialization,
                    onSelect: _selectSpec,
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
                error: (_, _) => EmptyState(
                  icon: Icons.cloud_off_outlined,
                  title: 'Something went wrong',
                  subtitle: 'Could not load doctors',
                  actionLabel: 'Retry',
                  onAction: () => ref.invalidate(doctorSearchProvider),
                ),
                data: (doctors) => doctors.isEmpty
                    ? const EmptyState(
                        icon: Icons.person_search_outlined,
                        title: 'No doctors found',
                        subtitle: 'Try adjusting your search or filters',
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(
                            AppSpacing.md, 8, AppSpacing.md, AppSpacing.md),
                        itemCount: doctors.length,
                        itemBuilder: (_, i) => AnimatedEntrance(
                          index: i,
                          slideY: 0,
                          slideX: 0.05,
                          child: _DoctorCard(doctor: doctors[i]),
                        ),
                      ),
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
          hintText: 'Search by name...',
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
          final label = _kSpecLabels[spec] ?? spec;
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

class _DoctorCard extends StatelessWidget {
  const _DoctorCard({required this.doctor});
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final initials =
        doctor.firstName.isNotEmpty ? doctor.firstName[0].toUpperCase() : 'D';

    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/patient/doctor-detail/${doctor.id}', extra: doctor);
      },
      child: Row(
        children: [
          Hero(
            tag: 'doctor-avatar-${doctor.id}',
            child: GradientAvatar(initials: initials, size: 52),
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
}
