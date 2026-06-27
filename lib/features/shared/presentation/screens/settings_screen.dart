import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/locale/locale_provider.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/theme/theme_mode_provider.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final t = context.t;

    return Scaffold(
      appBar: AppBar(title: Text(t.settings.title)),
      body: ResponsiveBody(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            AnimatedEntrance(
              child: _SettingsGroup(
                title: t.settings.account,
                children: [
                  _SettingsTile(
                    icon: Icons.person_outline,
                    label: t.settings.profile,
                    route: '/shared/profile',
                  ),
                  const _Divider(),
                  _SettingsTile(
                    icon: Icons.notifications_outlined,
                    label: t.settings.notifications,
                    route: '/shared/notifications',
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.md),
            AnimatedEntrance(
              index: 1,
              child: _SettingsGroup(
                title: t.settings.appearance,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: _ThemeModeSelector(
                      mode: themeMode,
                      onChanged: (m) =>
                          ref.read(themeModeProvider.notifier).setMode(m),
                    ),
                  ),
                  const _Divider(),
                  _LanguageTile(
                    locale: locale,
                    onTap: () => _showLanguagePicker(context, ref, locale),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.md),
            AnimatedEntrance(
              index: 2,
              child: _SettingsGroup(
                children: [
                  ListTile(
                    leading: const Icon(Icons.logout, color: AppColors.error),
                    title: Text(t.settings.logoutTitle,
                        style: const TextStyle(
                            color: AppColors.error,
                            fontWeight: FontWeight.w600)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg)),
                    onTap: () => _confirmLogout(context, ref),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.lg),
            Center(
              child: Text(
                t.settings.version,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    AppLocale? current,
  ) async {
    final t = context.t;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      // The list (System default + 6 languages) can be taller than the default
      // sheet height on smaller screens, so allow it to grow and scroll.
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    t.settings.language,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              // Options scroll if they don't all fit; Flexible keeps the sheet
              // sized to its content when they do.
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // "System default" follows the phone language.
                      _LanguageOption(
                        label: t.settings.languageSystem,
                        selected: current == null,
                        onTap: () {
                          ref.read(localeProvider.notifier).setLocale(null);
                          Navigator.pop(sheetContext);
                        },
                      ),
                      for (final entry in localeDisplayNames.entries)
                        _LanguageOption(
                          label: entry.value,
                          selected: current == entry.key,
                          onTap: () {
                            ref
                                .read(localeProvider.notifier)
                                .setLocale(entry.key);
                            Navigator.pop(sheetContext);
                          },
                        ),
                    ],
                  ),
                ),
              ),
              const Gap(AppSpacing.sm),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.settings.logoutTitle),
        content: Text(t.settings.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(t.settings.logoutTitle),
          ),
        ],
      ),
    );
    if (confirm == true) ref.read(authProvider.notifier).logout();
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({this.title, required this.children});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title!.toUpperCase(),
              style: TextStyle(
                color: c.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
        Container(
          decoration: BoxDecoration(
            color: c.surfaceAlt,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: c.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: context.colors.primaryText),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push(route),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({required this.locale, required this.onTap});

  final AppLocale? locale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final current =
        locale == null ? context.t.settings.languageSystem : localeDisplayNames[locale]!;
    return ListTile(
      leading: Icon(Icons.language_outlined, color: context.colors.primaryText),
      title: Text(context.t.settings.language),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(current,
              style: TextStyle(color: context.colors.textSecondary)),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: selected
          ? const Icon(Icons.check_rounded, color: AppColors.primary)
          : null,
      onTap: onTap,
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) =>
      Divider(height: 1, indent: 56, color: context.colors.border);
}

class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector({required this.mode, required this.onChanged});

  final ThemeMode mode;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<ThemeMode>(
        showSelectedIcon: false,
        segments: [
          ButtonSegment(value: ThemeMode.system, label: Text(t.settings.themeSystem)),
          ButtonSegment(value: ThemeMode.light, label: Text(t.settings.themeLight)),
          ButtonSegment(value: ThemeMode.dark, label: Text(t.settings.themeDark)),
        ],
        selected: {mode},
        onSelectionChanged: (s) => onChanged(s.first),
      ),
    );
  }
}
