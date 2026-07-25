import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/gradient_avatar.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Horizontal switcher for which profile new bookings/medications/records
/// get created under: the account holder ("Myself", always first) or one of
/// their managed family members, with a trailing "+ Add" shortcut. Tapping a
/// chip flips [activeProfileProvider], which the booking / medication-create
/// / record-upload flows read at submit time.
///
/// Placed at the very top of the patient home screen, above all other
/// content, by design — the active profile needs to always be on screen so a
/// patient can't forget whose profile they're currently acting under and,
/// say, book an appointment for themselves when they meant to book it for
/// their child.
class ProfileSwitcher extends ConsumerWidget {
  const ProfileSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(activeProfileProvider);
    final auth = ref.watch(authProvider);
    final myName = auth is AuthAuthenticated ? auth.displayName : '';
    final dependents =
        ref.watch(dependentsProvider).asData?.value ?? const [];
    final c = context.colors;

    return SizedBox(
      height: 76,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _ProfileChip(
            label: context.t.family.myself,
            avatar: GradientAvatar(initials: myName, size: 44),
            selected: active == null,
            onTap: () {
              HapticFeedback.selectionClick();
              ref.read(activeProfileProvider.notifier).state = null;
            },
          ),
          for (final dependent in dependents)
            _ProfileChip(
              label: dependent.firstName.isNotEmpty
                  ? dependent.firstName
                  : dependent.fullName,
              avatar: GradientAvatar(initials: dependent.fullName, size: 44),
              selected: active?.id == dependent.id,
              onTap: () {
                HapticFeedback.selectionClick();
                ref.read(activeProfileProvider.notifier).state = dependent;
              },
            ),
          _ProfileChip(
            label: context.t.family.addFamilyMember,
            avatar: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: c.primarySurface,
                border: Border.all(color: c.border),
              ),
              child: Icon(Icons.add_rounded, color: c.primaryText),
            ),
            selected: false,
            onTap: () {
              HapticFeedback.lightImpact();
              context.push('/patient/family/add');
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileChip extends StatelessWidget {
  const _ProfileChip({
    required this.label,
    required this.avatar,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Widget avatar;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: avatar,
            ),
            const Gap(4),
            SizedBox(
              width: 60,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? c.primaryText : c.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
