// =============================================================================
// password_pages.dart — Pages Mot de Passe FinTemp
// =============================================================================
// Emplacement : features/auth/presentation/pages/register/password_pages.dart
//
// Regroupe les 4 pages liées au mot de passe :
//   CreatePasswordPage   → choix du mot de passe (inscription)
//   ForgotPasswordPage   → saisie email (récupération)
//   ResetPasswordPage    → nouveau mot de passe
//   ResetSuccessPage     → confirmation réinitialisation
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../core/design_system/buttons/app_button.dart';
import '../../../../../core/design_system/inputs/app_text_field.dart';
import '../widgets/auth_widgets.dart';

// =============================================================================
// CreatePasswordPage — Choix du mot de passe (inscription)
// =============================================================================

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({super.key});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final _formKey      = GlobalKey<FormState>();
  final _passCtrl     = TextEditingController();
  final _confirmCtrl  = TextEditingController();
  bool  _isLoading    = false;

  // Critères de force du mot de passe
  bool get _hasLength   => _passCtrl.text.length >= 8;
  bool get _hasUpper    => _passCtrl.text.contains(RegExp(r'[A-Z]'));
  bool get _hasNumber   => _passCtrl.text.contains(RegExp(r'[0-9]'));
  bool get _hasSpecial  => _passCtrl.text.contains(RegExp(r'[!@#\$%^&*]'));

  int get _strength =>
      [_hasLength, _hasUpper, _hasNumber, _hasSpecial].where((b) => b).length;

  @override
  void dispose() {
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.go(AppRoutes.createPin);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AuthPageWrapper(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthHeader(
              title:    'Créer un mot de passe',
              subtitle: 'Choisissez un mot de passe fort pour sécuriser votre compte.',
            ),

            const SizedBox(height: AppSpacing.x3l),

            AppTextField.password(
              controller: _passCtrl,
              label:      'Mot de passe',
              onChanged:  (_) => setState(() {}),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Requis';
                if (v.length < 8) return '8 caractères minimum';
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.md),

            // Barre de force
            _PasswordStrengthBar(strength: _strength, isDark: isDark),

            const SizedBox(height: AppSpacing.md),

            // Critères
            _PasswordCriteria(
              hasLength:  _hasLength,
              hasUpper:   _hasUpper,
              hasNumber:  _hasNumber,
              hasSpecial: _hasSpecial,
              isDark:     isDark,
            ),

            const SizedBox(height: AppSpacing.x2l),

            AppTextField.password(
              controller: _confirmCtrl,
              label:      'Confirmer le mot de passe',
              validator: (v) {
                if (v == null || v.isEmpty) return 'Requis';
                if (v != _passCtrl.text) return 'Les mots de passe ne correspondent pas';
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.x3l),

            AppButton.primary(
              label:     'Continuer',
              isLoading: _isLoading,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Barre de force ────────────────────────────────────────────────────────────

class _PasswordStrengthBar extends StatelessWidget {
  const _PasswordStrengthBar({required this.strength, required this.isDark});
  final int  strength;
  final bool isDark;

  Color get _color => switch (strength) {
    0 => isDark ? AppColorsDark.neutral300 : AppColors.neutral300,
    1 => isDark ? AppColorsDark.error      : AppColors.error,
    2 => isDark ? AppColorsDark.warning    : AppColors.warning,
    3 => isDark ? AppColorsDark.info       : AppColors.info,
    _ => isDark ? AppColorsDark.success    : AppColors.success,
  };

  String get _label => switch (strength) {
    0 => '',
    1 => 'Très faible',
    2 => 'Faible',
    3 => 'Moyen',
    _ => 'Fort',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (i) => Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
              decoration: BoxDecoration(
                color: i < strength ? _color : (isDark ? AppColorsDark.neutral200 : AppColors.neutral200),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          )),
        ),
        if (_label.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            _label,
            style: AppTextStyles.labelSmall.copyWith(color: _color),
          ),
        ],
      ],
    );
  }
}

class _PasswordCriteria extends StatelessWidget {
  const _PasswordCriteria({
    required this.hasLength,
    required this.hasUpper,
    required this.hasNumber,
    required this.hasSpecial,
    required this.isDark,
  });
  final bool hasLength, hasUpper, hasNumber, hasSpecial, isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CriteriaRow(label: '8 caractères minimum', met: hasLength, isDark: isDark),
        _CriteriaRow(label: 'Une majuscule',         met: hasUpper,  isDark: isDark),
        _CriteriaRow(label: 'Un chiffre',            met: hasNumber, isDark: isDark),
        _CriteriaRow(label: 'Un caractère spécial',  met: hasSpecial, isDark: isDark),
      ],
    );
  }
}

class _CriteriaRow extends StatelessWidget {
  const _CriteriaRow({required this.label, required this.met, required this.isDark});
  final String label;
  final bool   met;
  final bool   isDark;

  @override
  Widget build(BuildContext context) {
    final color = met
        ? (isDark ? AppColorsDark.success : AppColors.success)
        : (isDark ? AppColorsDark.textTertiary : AppColors.textTertiary);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Icon(met ? Icons.check_circle_rounded : Icons.radio_button_unchecked, size: 16, color: color),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: AppTextStyles.bodySmall.copyWith(color: color)),
        ],
      ),
    );
  }
}

// =============================================================================
// ForgotPasswordPage — Saisie email de récupération
// =============================================================================

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailCtrl = TextEditingController();
  final _formKey   = GlobalKey<FormState>();
  bool  _isLoading = false;

  @override
  void dispose() { _emailCtrl.dispose(); super.dispose(); }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.push(AppRoutes.forgotOtp);
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageWrapper(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthHeader(
              title:    'Mot de passe oublié ?',
              subtitle: 'Entrez votre email pour recevoir un code de réinitialisation.',
            ),

            const SizedBox(height: AppSpacing.x3l),

            AppTextField(
              controller:      _emailCtrl,
              label:           'Email',
              hint:            'kofi@example.com',
              prefixIcon:      Icons.mail_outline_rounded,
              keyboardType:    TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email requis';
                if (!v.contains('@')) return 'Email invalide';
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.x3l),

            AppButton.primary(
              label:     'Envoyer le code',
              icon:      Icons.send_rounded,
              isLoading: _isLoading,
              onPressed: _submit,
            ),

            const SizedBox(height: AppSpacing.x2l),

            AuthFooterLink(
              text:     'Je me souviens !',
              linkText: 'Connexion',
              onTap:    () => context.go(AppRoutes.login),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// ResetPasswordPage — Nouveau mot de passe
// =============================================================================

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey     = GlobalKey<FormState>();
  final _passCtrl    = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool  _isLoading   = false;

  @override
  void dispose() { _passCtrl.dispose(); _confirmCtrl.dispose(); super.dispose(); }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.go(AppRoutes.resetSuccess);
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageWrapper(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthHeader(
              title:    'Nouveau mot de passe',
              subtitle: 'Choisissez un nouveau mot de passe pour votre compte.',
            ),
            const SizedBox(height: AppSpacing.x3l),
            AppTextField.password(
              controller: _passCtrl,
              label:      'Nouveau mot de passe',
              validator: (v) {
                if (v == null || v.isEmpty) return 'Requis';
                if (v.length < 8) return '8 caractères minimum';
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField.password(
              controller:      _confirmCtrl,
              label:           'Confirmer le mot de passe',
              textInputAction: TextInputAction.done,
              validator: (v) {
                if (v != _passCtrl.text) return 'Les mots de passe ne correspondent pas';
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.x3l),
            AppButton.primary(
              label:     'Enregistrer',
              isLoading: _isLoading,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// ResetSuccessPage — Confirmation succès
// =============================================================================

class ResetSuccessPage extends StatelessWidget {
  const ResetSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color:  isDark ? AppColorsDark.successLight : AppColors.successLight,
                  shape:  BoxShape.circle,
                ),
                child: Icon(Icons.check_rounded,
                  color: isDark ? AppColorsDark.success : AppColors.success,
                  size:  52,
                ),
              ),
              const SizedBox(height: AppSpacing.x2l),
              Text('Mot de passe\nmodifié !',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Votre mot de passe a été réinitialisé avec succès. Vous pouvez maintenant vous connecter.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              AppButton.primary(
                label:     'Se connecter',
                onPressed: () => context.go(AppRoutes.login),
              ),
              const SizedBox(height: AppSpacing.x2l),
            ],
          ),
        ),
      ),
    );
  }
}
