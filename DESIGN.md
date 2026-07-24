# Medalize Mobile — Design System

Source of truth for visual/UI decisions in `medalize_mb`. Read this before starting any UI task. If code and this doc disagree, treat the code in `lib/core/theme/` and `lib/core/constants/app_spacing.dart` as authoritative and fix this doc.

Stack: Flutter (Material 3, `useMaterial3: true`), `google_fonts` (Inter), Riverpod, GoRouter.

## Palette

Two tiers:

- **`AppColors`** (`lib/core/theme/app_theme.dart`) — brand constants that stay the same in light and dark: `primary` (`#2563EB`), `primaryDark`, `error`, `success`, `warning`, password-strength scale (`strengthWeak`/`strengthFair`/`strengthGood`/`strengthStrong`), `primaryGradient` (brand gradient), `authGradient` (deeper-blue backdrop behind the auth flow). Use these directly — they don't need `context`.
- **`ThemeColors`** (`lib/core/theme/theme_colors.dart`) — neutrals + accents that flip between light/dark, accessed via `context.colors` (extension `AppColorsX`): `background`, `surface`, `surfaceAlt`, `textPrimary`, `textSecondary`, `border`, `primarySurface`, `primaryText`, `shadow`.

**Rule:** if a color must look different in dark mode, it belongs in `ThemeColors` and is read via `context.colors.*`. If it's a fixed brand/semantic color (same in both themes), it's an `AppColors` constant. Never write a raw `Color(0xFF...)` in a screen/widget — if the value doesn't have a token yet, add one to `AppColors`/`ThemeColors` rather than inlining hex.

Status colors (appointment states) are centralized in `StatusChip.colorFor(status)` / `StatusChip.labelFor(status)` (`lib/core/widgets/status_chip.dart`) — reuse those instead of re-deriving a status → color mapping.

## Typography

Inter, loaded via `GoogleFonts.interTextTheme()` and layered into `ThemeData.textTheme` in `AppTheme._build`. Use `Theme.of(context).textTheme.<role>` — don't construct ad-hoc `TextStyle()` from scratch. `.copyWith(...)` on a theme style (e.g. to nudge `fontSize` or set a semantic `color`) is the established, accepted pattern throughout the codebase — that's not a violation.

| Role | Size | Weight |
|---|---|---|
| headlineLarge | 32 | w700 |
| headlineMedium | 28 | w700 |
| headlineSmall | 22 | w700 |
| titleLarge | 18 | w600 |
| titleMedium | 16 | w600 |
| titleSmall | 14 | w600 |
| bodyLarge | 16 | w400 |
| bodyMedium | 14 | w400 |
| bodySmall | 12 | w400 |
| labelLarge | 14 | w600 |
| labelMedium | 13 | w500 |
| labelSmall | 11 | w500 (letterSpacing 0.3) |

`bodyMedium`/`bodySmall`/`labelSmall` default to `textSecondary`; everything else defaults to `textPrimary`.

## Spacing, radius, motion

`lib/core/constants/app_spacing.dart`:

- **`AppSpacing`** — `xs=4, sm=8, md=16, lg=24, xl=32, xxl=48`. Also `cardMaxWidth=480`, `contentMaxWidth=640`, `mobileBreakpoint=600`, `tabletBreakpoint=1024` (used by `ResponsiveBody`).
- **`AppRadius`** — `xs=4, sm=8, md=12, lg=16, xl=20, xxl=24, pill=999`.

`lib/core/theme/app_motion.dart`:

- **`AppDuration`** — `fast=180ms, base=280ms, slow=400ms`, plus `stagger=55ms`/`maxStaggerItems=8` for staggered list entrances.
- **`AppCurve`** — `enter` (`easeOutCubic`), `emphasized` (`easeOutQuart`), `press` (`easeInOut`).

Use these constants instead of numeric literals for anything that should sit on the scale. A one-off value that doesn't match a rung (e.g. a `14`px content padding tuned for one field) is fine to leave as a literal — don't force-fit it to the nearest token.

**Elevation/shadow:** the app favors flat, bordered surfaces over `Material` elevation — cards use `elevation: 0` with a 1px `context.colors.border` outline. Use `context.colors.shadow` for the rare custom drop-shadow (see `AuthScaffold`'s card).

## Component conventions

`AppTheme` (`lib/core/theme/app_theme.dart`) centralizes ~20 component themes: buttons (filled/text/outlined), inputs, cards, chips, dialogs, bottom sheets, snackbars, switches, list tiles, FAB, popup/dropdown menus, tab bar, app bar, dividers. **Inherit from these — don't re-style a stock Material widget locally** (e.g. don't pass a one-off `ElevatedButton.styleFrom` when `FilledButton` already has the right look).

Wiring lives in `lib/main.dart`: `theme: AppTheme.light`, `darkTheme: AppTheme.dark`, `themeMode:` driven by `themeModeProvider` (`lib/core/theme/theme_mode_provider.dart`).

## Reusable widgets (`lib/core/widgets/`)

| Widget | Purpose |
|---|---|
| `AnimatedEntrance` | Standard fade + slide entrance animation |
| `AppBadge` | Small pill badge ("Primary", "This device", …), overflow-safe |
| `AppCard` | Interactive card: press-scale, spring release, tap/long-press |
| `AppChip` | Selectable chip, overflow-safe label |
| `AppSnackBar` | Snackbar helper matching the app's `snackBarTheme` |
| `EmptyState` | Icon + title/subtitle + optional action for empty lists |
| `GradientAvatar` | Avatar with a brand-gradient fallback background |
| `GreetingBanner` | Gradient welcome banner atop patient/doctor home screens |
| `NotificationBell` | App-bar bell icon with animated unread-count badge |
| `OtpCodeField` | 6-digit segmented OTP input |
| `PhoneField` | Phone number input with country-code picker |
| `PrimaryButton` (`LoadingFilledButton`) | Full-width filled button: press-scale, spring release, haptic, loading state |
| `Refreshable` | Wraps non-scrolling content so pull-to-refresh still works |
| `ResponsiveBody` | Centers + caps content width on tablets/landscape (`AppSpacing` breakpoints) |
| `SectionHeader` | "Title … action" row above content sections |
| `ShimmerSkeleton` | Loading skeleton (via `shimmer`) |
| `StatusChip` | Colored status pill; `StatusChip.colorFor`/`labelFor` are the single source of truth for appointment-status color/label |

Check this table before writing a new small widget — most patterns (badges, chips, empty states, loading buttons) already exist.

## Naming & preferred packages

- Screens: `<name>_screen.dart`, class `<Name>Screen`. Feature-local widgets live in `presentation/widgets/`; cross-feature reusable widgets live in `lib/core/widgets/`.
- Preferred packages already in `pubspec.yaml` — use these before adding a new dependency: `go_router` (routing), `flutter_riverpod` (state), `dio` (network), `cached_network_image` (remote images), `flutter_animate` (animation), `shimmer` (loading skeletons), `gap` (spacing widgets), `google_fonts` (typography), `slang`/`slang_flutter` (i18n — JSON-based, not gettext).
- No `flutter_svg` in the dependency tree; the app icon SVG source is build-time only (`flutter_launcher_icons`), not used at runtime.

## Checklist for new UI work

1. Reach for an existing widget in `lib/core/widgets/` before writing a new one.
2. Colors: `context.colors.*` for anything theme-dependent, `AppColors.*` for fixed brand/semantic colors. No raw `Color(0xFF...)` in feature code.
3. Spacing/radius: prefer `AppSpacing`/`AppRadius` rungs; a genuinely bespoke value is fine as a literal, don't force it onto the scale.
4. Type: `Theme.of(context).textTheme.<role>`, `.copyWith()` for tweaks — never a from-scratch `TextStyle()`.
5. Test in both light and dark (`AppTheme.light` / `AppTheme.dark`).
6. Test across all 6 locales for overflow using the existing harness: `test/support/locale_overflow_harness.dart` (`expectNoOverflowAcrossLocales`) — RU/TR/FR strings run long.
7. Golden tests live in `test/golden/` (see below) — add one for new core/widgets components; run `flutter test --update-goldens test/golden` after an intentional visual change.

## Golden tests

`test/golden/` covers component-level widgets (not full screens — those pull providers/network and are flaky) in both `AppTheme.light` and `AppTheme.dark`, using the same `_host(child, {width})` harness pattern as `test/responsive_ui_components_test.dart`. `GoogleFonts.config.allowRuntimeFetching` is disabled in `setUpAll` so nothing hits the network — Inter renders via the offline fallback font (goldens assert layout/color/shape, not glyph shape). With fetching disabled, `AppTheme.light`/`.dark` construction throws internally per weight (a `google_fonts` implementation detail: the rejected `Future` is never awaited by the package itself) and prints noise to stdout — expected and harmless. `_buildThemeIgnoringOfflineFontFetch` in the golden test scopes theme construction to its own `runZonedGuarded` so that specific, known error can't fail the test; any other error still propagates normally.

- Regenerate after an intentional visual change: `flutter test --update-goldens test/golden`
- Catch regressions: `flutter test test/golden`
