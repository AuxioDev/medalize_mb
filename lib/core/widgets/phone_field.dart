import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/utils/validators.dart';

// ── Country data ──────────────────────────────────────────────────────────────

class CountryCode {
  const CountryCode({
    required this.code,
    required this.name,
    required this.dialCode,
  });

  final String code;   // ISO 3166-1 alpha-2
  final String name;
  final String dialCode;

  String get flag {
    const base = 0x1F1E6 - 0x41;
    return code.toUpperCase().split('').map((c) => String.fromCharCode(c.codeUnitAt(0) + base)).join();
  }
}

const _countries = [
  CountryCode(code: 'AZ', name: 'Azerbaijan', dialCode: '+994'),
  CountryCode(code: 'AF', name: 'Afghanistan', dialCode: '+93'),
  CountryCode(code: 'AL', name: 'Albania', dialCode: '+355'),
  CountryCode(code: 'DZ', name: 'Algeria', dialCode: '+213'),
  CountryCode(code: 'AM', name: 'Armenia', dialCode: '+374'),
  CountryCode(code: 'AR', name: 'Argentina', dialCode: '+54'),
  CountryCode(code: 'AU', name: 'Australia', dialCode: '+61'),
  CountryCode(code: 'AT', name: 'Austria', dialCode: '+43'),
  CountryCode(code: 'BD', name: 'Bangladesh', dialCode: '+880'),
  CountryCode(code: 'BE', name: 'Belgium', dialCode: '+32'),
  CountryCode(code: 'BR', name: 'Brazil', dialCode: '+55'),
  CountryCode(code: 'CA', name: 'Canada', dialCode: '+1'),
  CountryCode(code: 'CN', name: 'China', dialCode: '+86'),
  CountryCode(code: 'CO', name: 'Colombia', dialCode: '+57'),
  CountryCode(code: 'CZ', name: 'Czechia', dialCode: '+420'),
  CountryCode(code: 'DK', name: 'Denmark', dialCode: '+45'),
  CountryCode(code: 'EG', name: 'Egypt', dialCode: '+20'),
  CountryCode(code: 'ET', name: 'Ethiopia', dialCode: '+251'),
  CountryCode(code: 'FI', name: 'Finland', dialCode: '+358'),
  CountryCode(code: 'FR', name: 'France', dialCode: '+33'),
  CountryCode(code: 'GE', name: 'Georgia', dialCode: '+995'),
  CountryCode(code: 'DE', name: 'Germany', dialCode: '+49'),
  CountryCode(code: 'GH', name: 'Ghana', dialCode: '+233'),
  CountryCode(code: 'GR', name: 'Greece', dialCode: '+30'),
  CountryCode(code: 'HU', name: 'Hungary', dialCode: '+36'),
  CountryCode(code: 'IN', name: 'India', dialCode: '+91'),
  CountryCode(code: 'ID', name: 'Indonesia', dialCode: '+62'),
  CountryCode(code: 'IR', name: 'Iran', dialCode: '+98'),
  CountryCode(code: 'IQ', name: 'Iraq', dialCode: '+964'),
  CountryCode(code: 'IL', name: 'Israel', dialCode: '+972'),
  CountryCode(code: 'IT', name: 'Italy', dialCode: '+39'),
  CountryCode(code: 'JP', name: 'Japan', dialCode: '+81'),
  CountryCode(code: 'JO', name: 'Jordan', dialCode: '+962'),
  CountryCode(code: 'KZ', name: 'Kazakhstan', dialCode: '+7'),
  CountryCode(code: 'KE', name: 'Kenya', dialCode: '+254'),
  CountryCode(code: 'KR', name: 'South Korea', dialCode: '+82'),
  CountryCode(code: 'KG', name: 'Kyrgyzstan', dialCode: '+996'),
  CountryCode(code: 'LB', name: 'Lebanon', dialCode: '+961'),
  CountryCode(code: 'MY', name: 'Malaysia', dialCode: '+60'),
  CountryCode(code: 'MA', name: 'Morocco', dialCode: '+212'),
  CountryCode(code: 'MX', name: 'Mexico', dialCode: '+52'),
  CountryCode(code: 'NL', name: 'Netherlands', dialCode: '+31'),
  CountryCode(code: 'NZ', name: 'New Zealand', dialCode: '+64'),
  CountryCode(code: 'NG', name: 'Nigeria', dialCode: '+234'),
  CountryCode(code: 'NO', name: 'Norway', dialCode: '+47'),
  CountryCode(code: 'PK', name: 'Pakistan', dialCode: '+92'),
  CountryCode(code: 'PH', name: 'Philippines', dialCode: '+63'),
  CountryCode(code: 'PL', name: 'Poland', dialCode: '+48'),
  CountryCode(code: 'PT', name: 'Portugal', dialCode: '+351'),
  CountryCode(code: 'RO', name: 'Romania', dialCode: '+40'),
  CountryCode(code: 'RU', name: 'Russia', dialCode: '+7'),
  CountryCode(code: 'SA', name: 'Saudi Arabia', dialCode: '+966'),
  CountryCode(code: 'SG', name: 'Singapore', dialCode: '+65'),
  CountryCode(code: 'ZA', name: 'South Africa', dialCode: '+27'),
  CountryCode(code: 'ES', name: 'Spain', dialCode: '+34'),
  CountryCode(code: 'SE', name: 'Sweden', dialCode: '+46'),
  CountryCode(code: 'CH', name: 'Switzerland', dialCode: '+41'),
  CountryCode(code: 'SY', name: 'Syria', dialCode: '+963'),
  CountryCode(code: 'TJ', name: 'Tajikistan', dialCode: '+992'),
  CountryCode(code: 'TH', name: 'Thailand', dialCode: '+66'),
  CountryCode(code: 'TN', name: 'Tunisia', dialCode: '+216'),
  CountryCode(code: 'TR', name: 'Turkey', dialCode: '+90'),
  CountryCode(code: 'TM', name: 'Turkmenistan', dialCode: '+993'),
  CountryCode(code: 'UA', name: 'Ukraine', dialCode: '+380'),
  CountryCode(code: 'AE', name: 'United Arab Emirates', dialCode: '+971'),
  CountryCode(code: 'GB', name: 'United Kingdom', dialCode: '+44'),
  CountryCode(code: 'US', name: 'United States', dialCode: '+1'),
  CountryCode(code: 'UZ', name: 'Uzbekistan', dialCode: '+998'),
  CountryCode(code: 'VN', name: 'Vietnam', dialCode: '+84'),
];

CountryCode _findCountry(String code) =>
    _countries.firstWhere((c) => c.code == code, orElse: () => _countries.first);

// ── PhoneField ────────────────────────────────────────────────────────────────

class PhoneField extends StatefulWidget {
  const PhoneField({
    super.key,
    required this.controller,
    this.initialCountryCode = 'AZ',
    this.textInputAction,
    this.onFieldSubmitted,
    this.onCountryChanged,
    this.label = 'Phone Number',
    this.hint = '50 123 45 67',
    this.optional = false,
  });

  final TextEditingController controller;
  final String initialCountryCode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<CountryCode>? onCountryChanged;
  final String label;
  final String? hint;
  final bool optional;

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  late CountryCode _country;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _country = _findCountry(widget.initialCountryCode);
    _focusNode = FocusNode()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _openPicker() {
    showModalBottomSheet<CountryCode>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CountryPickerSheet(
        selected: _country,
        onSelected: (c) {
          setState(() => _country = c);
          widget.onCountryChanged?.call(c);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (_) {
        if (widget.optional && widget.controller.text.trim().isEmpty) return null;
        return Validators.phone(widget.controller.text);
      },
      builder: (state) {
        final c = context.colors;
        final focused = _focusNode.hasFocus;
        final hasError = state.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: c.surfaceAlt,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: hasError
                      ? AppColors.error
                      : focused
                          ? AppColors.primary
                          : c.border,
                  width: focused || hasError ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  // ── Country prefix button ─────────────────────────
                  InkWell(
                    onTap: _openPicker,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 13),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _country.flag,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _country.dialCode,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: c.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            size: 18,
                            color: c.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ── Divider ───────────────────────────────────────
                  Container(
                    width: 1,
                    height: 24,
                    color: c.border,
                  ),
                  // ── Number input ──────────────────────────────────
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.phone,
                      textInputAction: widget.textInputAction,
                      onSubmitted: widget.onFieldSubmitted,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-\(\)]')),
                      ],
                      style: TextStyle(
                        fontSize: 15,
                        color: c.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle: TextStyle(color: c.textSecondary),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  state.errorText!,
                  style: Theme.of(context).inputDecorationTheme.errorStyle ??
                      const TextStyle(
                          fontSize: 12, color: AppColors.error),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ── Country picker bottom sheet ───────────────────────────────────────────────

class _CountryPickerSheet extends StatefulWidget {
  const _CountryPickerSheet({
    required this.selected,
    required this.onSelected,
  });

  final CountryCode selected;
  final ValueChanged<CountryCode> onSelected;

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final _search = TextEditingController();
  List<CountryCode> _visible = _countries;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _filter(String q) {
    final query = q.toLowerCase().trim();
    setState(() {
      _visible = query.isEmpty
          ? _countries
          : _countries
              .where((c) =>
                  c.name.toLowerCase().contains(query) ||
                  c.dialCode.contains(query) ||
                  c.code.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scroll) => Container(
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // ── Drag handle ───────────────────────────────────────────
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
            const Text(
              'Select Country',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            // ── Search ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _search,
                onChanged: _filter,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search country or code…',
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
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            // ── Country list ──────────────────────────────────────────
            Expanded(
              child: _visible.isEmpty
                  ? Center(
                      child: Text(
                        'No countries found',
                        style: TextStyle(color: c.textSecondary),
                      ),
                    )
                  : ListView.builder(
                      controller: scroll,
                      itemCount: _visible.length,
                      itemBuilder: (_, i) {
                        final c = _visible[i];
                        final selected = c.code == widget.selected.code;
                        return ListTile(
                          leading: Text(
                            c.flag,
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(
                            c.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                          trailing: Text(
                            c.dialCode,
                            style: TextStyle(
                              fontSize: 13,
                              color: selected
                                  ? context.colors.primaryText
                                  : context.colors.textSecondary,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                          selected: selected,
                          selectedTileColor:
                              AppColors.primary.withValues(alpha: 0.06),
                          onTap: () => widget.onSelected(c),
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
