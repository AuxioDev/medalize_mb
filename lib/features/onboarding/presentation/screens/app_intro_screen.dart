import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/onboarding/app_intro_provider.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// First-install welcome carousel: three pages introducing the key features,
/// shown once before login (see the `/intro` redirect in `app_router.dart`).
///
/// Not to be confused with `DoctorOnboardingScreen` — that is the doctor
/// profile wizard, an unrelated feature.
class AppIntroScreen extends ConsumerStatefulWidget {
  const AppIntroScreen({super.key});

  @override
  ConsumerState<AppIntroScreen> createState() => _AppIntroScreenState();
}

class _AppIntroScreenState extends ConsumerState<AppIntroScreen> {
  final _controller = PageController();
  int _page = 0;

  static const _pageCount = 3;

  bool get _isLastPage => _page == _pageCount - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// "Skip" and "Get Started" both land here: persist the one-way flag, flip
  /// the in-memory provider (so the router redirect stops targeting /intro)
  /// and move on to login.
  Future<void> _finish() async {
    await SecureStorage().saveAppIntroSeen();
    ref.read(appIntroSeenProvider.notifier).state = true;
    if (mounted) context.go('/auth/login');
  }

  void _next() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.t.appIntro;
    final pages = [
      (icon: Icons.search_rounded, title: t.page1Title, subtitle: t.page1Subtitle),
      (
        icon: Icons.smart_toy_outlined,
        title: t.page2Title,
        subtitle: t.page2Subtitle,
      ),
      (icon: Icons.shield_outlined, title: t.page3Title, subtitle: t.page3Subtitle),
    ];

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip — top-right, only while there is something left to skip.
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.xs, AppSpacing.sm, 0),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isLastPage ? 0 : 1,
                  child: IgnorePointer(
                    ignoring: _isLastPage,
                    child: TextButton(
                      onPressed: _finish,
                      child: Text(
                        t.skip,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pageCount,
                onPageChanged: (index) => setState(() => _page = index),
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return _IntroPage(
                    icon: page.icon,
                    title: page.title,
                    subtitle: page.subtitle,
                  );
                },
              ),
            ),
            _PageDots(count: _pageCount, current: _page),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.md),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: AppSpacing.cardMaxWidth),
                child: SizedBox(
                  width: double.infinity,
                  child: LoadingFilledButton(
                    label: _isLastPage ? t.getStarted : t.next,
                    onPressed: _isLastPage ? _finish : _next,
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

/// One carousel page: icon in a tinted circle (same shape language as the
/// splash logo), then title and subtitle. Scrollable so long translations on
/// small screens never overflow.
class _IntroPage extends StatelessWidget {
  const _IntroPage({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AppSpacing.cardMaxWidth),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: c.primarySurface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.25),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(icon, size: 56, color: AppColors.primary),
                    )
                        .animate()
                        .scale(
                          begin: const Offset(0.75, 0.75),
                          end: const Offset(1.0, 1.0),
                          duration: 500.ms,
                          curve: Curves.easeOutBack,
                        )
                        .fadeIn(duration: 300.ms),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: c.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 120.ms, duration: 350.ms)
                        .slideY(
                          begin: 0.15,
                          end: 0,
                          delay: 120.ms,
                          duration: 350.ms,
                          curve: Curves.easeOut,
                        ),
                    const SizedBox(height: AppSpacing.sm + 4),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: c.textSecondary,
                        fontSize: 15,
                        height: 1.45,
                      ),
                    ).animate().fadeIn(delay: 220.ms, duration: 350.ms),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Dot indicator: the active dot stretches and takes the primary color.
class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: i == current ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == current ? AppColors.primary : c.border,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}
