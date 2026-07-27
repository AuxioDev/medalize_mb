import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/features/locations/data/repository/location_repository.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// A form field that opens a searchable, region-grouped bottom sheet over
/// `GET /locations/` instead of accepting free-text city input. The form
/// value is always the canonical location key (e.g. `'baku'`), never a
/// display label — callers send that key straight to the API.
class LocationPickerField extends StatelessWidget {
  const LocationPickerField({
    super.key,
    required this.value,
    required this.onChanged,
    this.decoration = const InputDecoration(),
    this.validator,
    this.allowClear = false,
    this.fallbackLabel,
  });

  /// Canonical location key, or null when nothing is selected.
  final String? value;
  final ValueChanged<String?> onChanged;
  final InputDecoration decoration;
  final FormFieldValidator<String?>? validator;

  /// Shows an "All cities" row in the sheet that clears the selection.
  final bool allowClear;

  /// Displayed for [value] before the locations list has finished loading
  /// — e.g. the `city_display` a workplace was already loaded with.
  final String? fallbackLabel;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final asyncRegions = ref.watch(locationsProvider);
        return FormField<String>(
          initialValue: value,
          validator: validator,
          builder: (state) {
            final c = context.colors;
            final regions = asyncRegions.valueOrNull ?? const [];
            final label = _labelFor(regions, value) ?? fallbackLabel;
            final isLoading = asyncRegions.isLoading;
            final hasError = asyncRegions.hasError;

            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: isLoading
                  ? null
                  : hasError
                      ? () => ref.invalidate(locationsProvider)
                      : () => _openPicker(context, ref, regions, state),
              child: InputDecorator(
                decoration: decoration.copyWith(
                  errorText: state.errorText,
                  suffixIcon: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : Icon(
                          hasError
                              ? Icons.refresh_rounded
                              : Icons.arrow_drop_down_rounded,
                          color: c.textSecondary,
                        ),
                ),
                child: Text(
                  hasError
                      ? context.t.locations.couldNotLoad
                      : (label ?? decoration.hintText ?? ''),
                  style: TextStyle(
                    color: label == null || hasError
                        ? c.textSecondary
                        : c.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        );
      },
    );
  }

  String? _labelFor(List<LocationRegion> regions, String? key) {
    if (key == null || key.isEmpty) return null;
    for (final region in regions) {
      for (final city in region.cities) {
        if (city.key == key) return city.label;
      }
    }
    return null;
  }

  Future<void> _openPicker(
    BuildContext context,
    WidgetRef ref,
    List<LocationRegion> regions,
    FormFieldState<String> state,
  ) async {
    // '' is the explicit "All cities" clear sentinel — distinct from `null`,
    // which means the sheet was dismissed without a choice.
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _LocationPickerSheet(
        regions: regions,
        selectedKey: value,
        allowClear: allowClear,
      ),
    );
    if (selected == null) return;
    final newValue = selected.isEmpty ? null : selected;
    state.didChange(newValue);
    onChanged(newValue);
  }
}

class _LocationPickerSheet extends StatefulWidget {
  const _LocationPickerSheet({
    required this.regions,
    required this.selectedKey,
    required this.allowClear,
  });

  final List<LocationRegion> regions;
  final String? selectedKey;
  final bool allowClear;

  @override
  State<_LocationPickerSheet> createState() => _LocationPickerSheetState();
}

class _LocationPickerSheetState extends State<_LocationPickerSheet> {
  final _search = TextEditingController();
  late List<LocationRegion> _visible = widget.regions;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _filter(String q) {
    final query = q.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _visible = widget.regions;
        return;
      }
      _visible = widget.regions
          .map((region) {
            final regionMatches = region.label.toLowerCase().contains(query);
            final cities = regionMatches
                ? region.cities
                : region.cities
                    .where((c) => c.label.toLowerCase().contains(query))
                    .toList();
            return LocationRegion(key: region.key, label: region.label, cities: cities);
          })
          .where((region) => region.cities.isNotEmpty)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final totalVisible = _visible.fold<int>(0, (sum, r) => sum + r.cities.length);
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
              context.t.locations.pickCity,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _search,
                onChanged: _filter,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: context.t.locations.searchHint,
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  suffixIcon: _search.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: () {
                            _search.clear();
                            _filter('');
                          },
                        )
                      : null,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            Expanded(
              child: totalVisible == 0
                  ? Center(
                      child: Text(
                        context.t.locations.noResultsFound,
                        style: TextStyle(color: c.textSecondary),
                      ),
                    )
                  : ListView(
                      controller: scroll,
                      children: [
                        if (widget.allowClear && _search.text.trim().isEmpty)
                          ListTile(
                            leading: const Icon(Icons.public_rounded),
                            title: Text(
                              context.t.locations.allCities,
                              style: TextStyle(
                                fontWeight: widget.selectedKey == null
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            selected: widget.selectedKey == null,
                            selectedTileColor:
                                Theme.of(context).colorScheme.primary.withValues(alpha: 0.06),
                            onTap: () => Navigator.of(context).pop(''),
                          ),
                        for (final region in _visible) ...[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                            child: Text(
                              region.label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: c.textSecondary,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          for (final city in region.cities)
                            ListTile(
                              title: Text(
                                city.label,
                                style: TextStyle(
                                  fontWeight: city.key == widget.selectedKey
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                              trailing: city.type == 'city'
                                  ? Icon(Icons.location_city_rounded,
                                      size: 18, color: c.textSecondary)
                                  : null,
                              selected: city.key == widget.selectedKey,
                              selectedTileColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.06),
                              onTap: () => Navigator.of(context).pop(city.key),
                            ),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
