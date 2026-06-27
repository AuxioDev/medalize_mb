import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/gradient_avatar.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _editing = false;
  bool _saving = false;
  bool _uploadingAvatar = false;
  String? _role;
  String? _avatarUrl;
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _phone;
  late TextEditingController _allergies;
  late TextEditingController _chronicConditions;
  late TextEditingController _medications;
  late TextEditingController _bio;
  late TextEditingController _consultationFee;
  String? _saveError;

  @override
  void initState() {
    super.initState();
    final auth = ref.read(authProvider);
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _phone = TextEditingController();
    _allergies = TextEditingController();
    _chronicConditions = TextEditingController();
    _medications = TextEditingController();
    _bio = TextEditingController();
    _consultationFee = TextEditingController();
    if (auth is AuthAuthenticated) {
      _role = auth.role;
      _fetchProfile();
    }
  }

  Future<void> _fetchProfile() async {
    try {
      final res = await ref.read(dioClientProvider).get('/auth/me/');
      final d = res.data as Map<String, dynamic>;
      _firstName.text = d['first_name'] as String? ?? '';
      _lastName.text = d['last_name'] as String? ?? '';
      _phone.text = d['phone'] as String? ?? '';
      _avatarUrl = d['avatar_url'] as String?;
      if (_role == 'patient') {
        final profile = d['profile'] as Map<String, dynamic>? ?? {};
        _allergies.text = profile['allergies'] as String? ?? '';
        _chronicConditions.text = profile['chronic_conditions'] as String? ?? '';
        _medications.text = profile['medications'] as String? ?? '';
      }
      if (_role == 'doctor') {
        final profile = d['profile'] as Map<String, dynamic>? ?? {};
        _bio.text = profile['bio'] as String? ?? '';
        _consultationFee.text = profile['consultation_fee'] as String? ?? '';
      }
      if (mounted) setState(() {});
    } catch (_) {}
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _phone.dispose();
    _allergies.dispose();
    _chronicConditions.dispose();
    _medications.dispose();
    _bio.dispose();
    _consultationFee.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadAvatar() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85, maxWidth: 1024);
    if (picked == null || !mounted) return;
    setState(() => _uploadingAvatar = true);
    try {
      final form = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(picked.path, filename: 'avatar.jpg'),
      });
      final res = await ref.read(dioClientProvider).post('/auth/profile/avatar/', data: form);
      final url = (res.data as Map<String, dynamic>)['avatar_url'] as String?;
      if (mounted) setState(() => _avatarUrl = url);
    } catch (_) {
    } finally {
      if (mounted) setState(() => _uploadingAvatar = false);
    }
  }

  Future<void> _save() async {
    setState(() {
      _saving = true;
      _saveError = null;
    });
    try {
      await ref.read(dioClientProvider).patch('/auth/me/', data: {
        'first_name': _firstName.text.trim(),
        'last_name': _lastName.text.trim(),
        'phone': _phone.text.trim(),
      });
      if (_role == 'patient') {
        await ref.read(dioClientProvider).patch('/auth/profile/patient/', data: {
          'allergies': _allergies.text.trim(),
          'chronic_conditions': _chronicConditions.text.trim(),
          'medications': _medications.text.trim(),
        });
      }
      if (_role == 'doctor') {
        final feeText = _consultationFee.text.trim();
        await ref.read(dioClientProvider).patch('/doctor/profile/', data: {
          'bio': _bio.text.trim(),
          if (feeText.isNotEmpty) 'consultation_fee': feeText,
        });
      }
      if (mounted) setState(() => _editing = false);
    } on ApiException catch (e) {
      if (mounted) setState(() => _saveError = e.userMessage);
    } catch (_) {
      if (mounted) setState(() => _saveError = context.t.profile.failedToSave);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showChangePassword() {
    final t = context.t;
    final oldCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + AppSpacing.lg,
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.profile.changePassword,
                style: Theme.of(ctx).textTheme.titleLarge),
            const Gap(AppSpacing.md),
            TextField(
              controller: oldCtrl,
              obscureText: true,
              decoration:
                  InputDecoration(labelText: t.profile.currentPassword),
            ),
            const Gap(12),
            TextField(
              controller: newCtrl,
              obscureText: true,
              decoration: InputDecoration(labelText: t.profile.newPassword),
            ),
            const Gap(12),
            TextField(
              controller: confirmCtrl,
              obscureText: true,
              decoration:
                  InputDecoration(labelText: t.profile.confirmNewPassword),
            ),
            const Gap(AppSpacing.md),
            LoadingFilledButton(
              label: t.profile.changePassword,
              onPressed: () async {
                if (newCtrl.text != confirmCtrl.text) return;
                try {
                  await ref.read(authProvider.notifier).changePassword(
                        oldPassword: oldCtrl.text,
                        newPassword: newCtrl.text,
                      );
                  if (ctx.mounted) Navigator.pop(ctx);
                } catch (_) {}
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final email = auth is AuthAuthenticated ? auth.email : '';
    final initialsSource =
        _firstName.text.isNotEmpty ? _firstName.text : (email.isNotEmpty ? email : 'U');

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.profile.title),
        actions: [
          if (!_editing)
            TextButton(
              onPressed: () => setState(() => _editing = true),
              child: Text(context.t.common.edit),
            )
          else
            TextButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(context.t.common.save),
            ),
        ],
      ),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              GestureDetector(
                onTap: _uploadingAvatar ? null : _pickAndUploadAvatar,
                child: Stack(
                  children: [
                    _avatarUrl != null
                        ? CircleAvatar(
                            radius: 48,
                            backgroundImage: NetworkImage(_avatarUrl!),
                          )
                        : GradientAvatar(initials: initialsSource, size: 96),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: _uploadingAvatar
                            ? const Padding(
                                padding: EdgeInsets.all(6),
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(AppSpacing.sm),
              Text(email, style: Theme.of(context).textTheme.bodyMedium),
              const Gap(AppSpacing.lg),
              TextField(
                controller: _firstName,
                enabled: _editing,
                decoration:
                    InputDecoration(labelText: context.t.profile.firstName),
              ),
              const Gap(12),
              TextField(
                controller: _lastName,
                enabled: _editing,
                decoration:
                    InputDecoration(labelText: context.t.profile.lastName),
              ),
              const Gap(12),
              TextField(
                controller: _phone,
                enabled: _editing,
                keyboardType: TextInputType.phone,
                decoration:
                    InputDecoration(labelText: context.t.profile.phone),
              ),
              if (_role == 'doctor') ...[
                const Gap(AppSpacing.lg),
                Text(context.t.profile.professionalInfo, style: Theme.of(context).textTheme.titleSmall),
                const Gap(12),
                TextField(
                  controller: _bio,
                  enabled: _editing,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: context.t.profile.bio,
                    alignLabelWithHint: true,
                    hintText: context.t.profile.bioHint,
                  ),
                ),
                const Gap(12),
                TextField(
                  controller: _consultationFee,
                  enabled: _editing,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: context.t.profile.consultationFee,
                    hintText: '50.00',
                    prefixText: '\$ ',
                  ),
                ),
              ],
              if (_role == 'patient') ...[
                const Gap(AppSpacing.lg),
                Text(
                  context.t.profile.medicalInfo,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(12),
                TextField(
                  controller: _allergies,
                  enabled: _editing,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: context.t.profile.allergies,
                    alignLabelWithHint: true,
                    hintText: context.t.profile.allergiesHint,
                  ),
                ),
                const Gap(12),
                TextField(
                  controller: _chronicConditions,
                  enabled: _editing,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: context.t.profile.chronicConditions,
                    alignLabelWithHint: true,
                    hintText: context.t.profile.chronicConditionsHint,
                  ),
                ),
                const Gap(12),
                TextField(
                  controller: _medications,
                  enabled: _editing,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: context.t.profile.medications,
                    alignLabelWithHint: true,
                    hintText: context.t.profile.medicationsHint,
                  ),
                ),
              ],
              if (_saveError != null) ...[
                const Gap(AppSpacing.sm),
                Text(_saveError!,
                    style: const TextStyle(color: AppColors.error)),
              ],
              const Gap(AppSpacing.lg),
              Align(
                alignment: Alignment.centerLeft,
                child: Material(
                  color: Colors.transparent,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.lock_outline),
                    title: Text(context.t.profile.changePassword),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _showChangePassword,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
