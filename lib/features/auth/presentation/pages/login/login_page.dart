// =============================================================================
// login_page.dart — Connexion FinTemp
// =============================================================================
// Emplacement : features/auth/presentation/pages/login/login_page.dart
//
// Écran de connexion principal avec :
//   - Email + mot de passe
//   - Boutons sociaux (Google, Apple)
//   - Lien "Mot de passe oublié"
//   - Navigation vers login biométrique / PIN
//   - Lien vers l'inscription
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../core/design_system/buttons/app_button.dart';
import '../../../../../core/design_system/inputs/app_text_field.dart';
import '../../widgets/auth_widgets.dart';
import '../widgets/auth_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey     = GlobalKey<FormState>();
  final _emailCtrl   = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool  _isLoading   = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // Simulation délai réseau
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.go(AppRoutes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.lg),

                // ── Logo ──────────────────────────────────────────────
                Container(
                  width:  44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColorsDark.primarySurface
                        : AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'FT',
                      style: AppTextStyles.titleSmall.copyWith(
                        color:      isDark ? AppColorsDark.primary : AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.x2l),

                // ── Titre ─────────────────────────────────────────────
                const AuthHeader(
                  title:    'Bon retour 👋',
                  subtitle: 'Connectez-vous pour accéder à votre compte.',
                ),

                const SizedBox(height: AppSpacing.x3l),

                // ── Formulaire ────────────────────────────────────────
                AppTextField(
                  controller:      _emailCtrl,
                  label:           'Email',
                  hint:            'kofi@example.com',
                  prefixIcon:      Icons.mail_outline_rounded,
                  keyboardType:    TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email requis';
                    if (!v.contains('@')) return 'Email invalide';
                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.md),

                AppTextField.password(
                  controller:      _passwordCtrl,
                  label:           'Mot de passe',
                  textInputAction: TextInputAction.done,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Mot de passe requis';
                    if (v.length < 6) return '6 caractères minimum';
                    return null;
                  },
                ),

                // ── Lien mot de passe oublié ──────────────────────────
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(AppRoutes.forgotPassword),
                    child: Text(
                      'Mot de passe oublié ?',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isDark ? AppColorsDark.primary : AppColors.primary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Bouton connexion ──────────────────────────────────
                AppButton.primary(
                  label:     'Se connecter',
                  isLoading: _isLoading,
                  onPressed: _submit,
                ),

                const SizedBox(height: AppSpacing.x2l),

                // ── Options alternatives ──────────────────────────────
                const AuthDivider(),

                const SizedBox(height: AppSpacing.x2l),

                const AuthSocialButtons(),

                const SizedBox(height: AppSpacing.x2l),

                // Bouton PIN / biométrie
                _buildQuickLoginOptions(isDark),

                const SizedBox(height: AppSpacing.x3l),

                // ── Lien inscription ──────────────────────────────────
                AuthFooterLink(
                  text:     'Pas encore de compte ?',
                  linkText: 'Créer un compte',
                  onTap:    () => context.go(AppRoutes.register),
                ),

                const SizedBox(height: AppSpacing.x2l),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickLoginOptions(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _QuickLoginButton(
          icon:    Icons.dialpad_rounded,
          label:   'PIN',
          onTap:   () => context.push(AppRoutes.loginPin),
          isDark:  isDark,
        ),
        const SizedBox(width: AppSpacing.lg),
        _QuickLoginButton(
          icon:    Icons.fingerprint_rounded,
          label:   'Biométrie',
          onTap:   () => context.push(AppRoutes.loginBiometric),
          isDark:  isDark,
        ),
      ],
    );
  }
}

class _QuickLoginButton extends StatelessWidget {
  const _QuickLoginButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isDark,
  });
  final IconData     icon;
  final String       label;
  final VoidCallback onTap;
  final bool         isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width:  52,
            height: 52,
            decoration: BoxDecoration(
              color: isDark ? AppColorsDark.inputBackground : AppColors.inputBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              size:  24,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
