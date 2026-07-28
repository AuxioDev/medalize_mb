import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_model.dart';
import 'package:medalize_mb/features/hospital/data/repository/hospital_repository.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// A form field that opens a server-searched bottom sheet over
/// `GET /api/hospitals/?q=&city=` — the doctor's workplace-hospital picker,
/// also reused by hospital registration's claim search. Unlike
/// [LocationPickerField] (a fixed, preloaded list), there is no local list
/// to look up a label from, so the caller must track [selectedLabel] itself
/// (from whichever [HospitalModel] [onSelected] last returned, or a
/// server-loaded display value when editing something that already has a
/// hospital set).
///
/// Requires [city] and is disabled until it's set — a hospital registry
/// entry with no city can't be deduplicated or merged on the backend (see
/// apps.hospitals.matching), so "add your variant" has nothing sensible to
/// scope a new entry to without one.
class HospitalPickerField extends StatelessWidget {
  const HospitalPickerField({
    super.key,
    required this.selectedId,
    required this.selectedLabel,
    required this.city,
    required this.onSelected,
    this.decoration = const InputDecoration(),
    this.validator,
  });

  final String? selectedId;
  final String? selectedLabel;
  final String? city;
  final ValueChanged<HospitalModel?> onSelected;
  final InputDecoration decoration;
  final FormFieldValidator<String?>? validator;

  bool get _enabled => city != null && city!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectedId,
      validator: validator,
      builder: (state) {
        final c = context.colors;
        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _enabled ? () => _openPicker(context, state) : null,
          child: InputDecorator(
            decoration: decoration.copyWith(
              enabled: _enabled,
              errorText: state.errorText,
              helperText: _enabled ? null : context.t.hospitalPicker.selectCityFirst,
              suffixIcon: Icon(Icons.arrow_drop_down_rounded, color: c.textSecondary),
            ),
            child: Text(
              selectedLabel ?? decoration.hintText ?? '',
              style: TextStyle(
                color: selectedLabel == null ? c.textSecondary : c.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }

  Future<void> _openPicker(
    BuildContext context,
    FormFieldState<String> state,
  ) async {
    final result = await showModalBottomSheet<HospitalModel>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _HospitalPickerSheet(city: city!),
    );
    if (result == null) return;
    state.didChange(result.id);
    onSelected(result);
  }
}

class _HospitalPickerSheet extends ConsumerStatefulWidget {
  const _HospitalPickerSheet({required this.city});

  final String city;

  @override
  ConsumerState<_HospitalPickerSheet> createState() => _HospitalPickerSheetState();
}

class _HospitalPickerSheetState extends ConsumerState<_HospitalPickerSheet> {
  final _search = TextEditingController();
  Timer? _debounce;
  // Bumped on every new request so a slow, stale response can never
  // overwrite a newer one that already landed (classic search-race guard).
  int _requestGeneration = 0;
  List<HospitalModel> _results = const [];
  bool _loading = true;
  bool _creating = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _runSearch('');
    _search.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  void _onQueryChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _runSearch(_search.text.trim());
    });
  }

  Future<void> _runSearch(String query) async {
    final generation = ++_requestGeneration;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final results = await ref
          .read(hospitalRepositoryProvider)
          .search(q: query, city: widget.city);
      if (!mounted || generation != _requestGeneration) return;
      setState(() {
        _results = results;
        _loading = false;
      });
    } catch (_) {
      if (!mounted || generation != _requestGeneration) return;
      setState(() {
        _error = context.t.locations.couldNotLoad;
        _loading = false;
      });
    }
  }

  Future<void> _addVariant() async {
    final name = _search.text.trim();
    if (name.isEmpty || _creating) return;
    setState(() => _creating = true);
    try {
      final hospital = await ref
          .read(hospitalRepositoryProvider)
          .create(name: name, city: widget.city);
      if (!mounted) return;
      Navigator.of(context).pop(hospital);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _creating = false;
        _error = context.t.common.somethingWrong;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final query = _search.text.trim();
    // Only offer "add your variant" once a real search has come back empty
    // — not while still loading or on a transient error, and not for a
    // blank query (nothing to name the new entry).
    final showAddTile = !_loading && _error == null && _results.isEmpty && query.isNotEmpty;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scroll) => Material(
        color: c.surface,
        clipBehavior: Clip.antiAlias,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: c.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              context.t.hospitalPicker.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _search,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: context.t.hospitalPicker.searchHint,
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  suffixIcon: _search.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: () => _search.clear(),
                        )
                      : null,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            Expanded(child: _body(context, scroll, showAddTile)),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context, ScrollController scroll, bool showAddTile) {
    final c = context.colors;
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: TextButton(
          onPressed: () => _runSearch(_search.text.trim()),
          child: Text(_error!),
        ),
      );
    }
    if (_results.isEmpty && !showAddTile) {
      return Center(
        child: Text(
          context.t.hospitalPicker.noResultsFound,
          style: TextStyle(color: c.textSecondary),
        ),
      );
    }
    return ListView(
      controller: scroll,
      children: [
        if (showAddTile)
          ListTile(
            leading: _creating
                ? const Padding(
                    padding: EdgeInsets.all(4),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : const Icon(Icons.add_circle_outline_rounded),
            title: Text(
              context.t.hospitalPicker.addVariant(name: _search.text.trim()),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            enabled: !_creating,
            onTap: _addVariant,
          ),
        for (final hospital in _results)
          ListTile(
            title: Text(hospital.name),
            subtitle: hospital.address.isNotEmpty ? Text(hospital.address) : null,
            trailing: hospital.isPendingReview
                ? Chip(
                    label: Text(
                      context.t.hospitalPicker.pendingReview,
                      style: const TextStyle(fontSize: 11),
                    ),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )
                : null,
            onTap: () => Navigator.of(context).pop(hospital),
          ),
      ],
    );
  }
}
