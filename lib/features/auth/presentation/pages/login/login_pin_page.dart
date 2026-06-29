// =============================================================================
// login_pin_page.dart — Connexion PIN FinTemp
// =============================================================================
// Emplacement : features/auth/presentation/pages/login/login_pin_page.dart
//
// Connexion rapide via code PIN à 4 chiffres.
// Affiche l'avatar + nom de l'utilisateur reconnu.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../app/theme/app_radius.dart';
import '../../../../../core/design_system/buttons/app_button.dart';
import '../../../../../core/design_system/inputs/app_text_field.dart';
import '../../../../../core/helpers/dummy_data.dart';
import '../../../../../core/widgets/app_avatar.dart';

class LoginPinPage extends StatefulWidget {
  const LoginPinPage({super.key});

  @override
  State<LoginPinPage> createState() => _LoginPinPageState();
}

class _LoginPinPageState extends State<LoginPinPage> {
  String _pin         = '';
  bool   _isError     = false;
  bool   _isLoading   = false;
  static const int _pinLength = 4;
  static const String _correctPin = '1234'; // Dummy PIN

  void _onPinCompleted(String pin) async {
    setState(() {
      _pin      = pin;
      _isError  = false;
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    if (pin == _correctPin) {
      context.go(AppRoutes.dashboard);
    } else {
      setState(() {
        _isError   = true;
        _isLoading = false;
        _pin       = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── AppBar custom ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical:   AppSpacing.md,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: isDark ? AppColorsDark.inputBackground : AppColors.inputBackground,
                        borderRadius: AppRadius.mdRadius,
                      ),
                      child: Icon(Icons.arrow_back_rounded,
                        color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── Avatar utilisateur ─────────────────────────────────────
            AppAvatar(
              initials:  DummyData.user.initials,
              size:      AppAvatarSize.x2l,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              DummyData.user.fullName,
              style: AppTextStyles.titleLarge.copyWith(
                color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Entrez votre code PIN',
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: AppSpacing.x4l),

            // ── Champ PIN ──────────────────────────────────────────────
            Padding(
              padding: AppSpacing.screenPaddingH,
              child: _isLoading
                  ? const SizedBox(
                      height: 60,
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    )
                  : AppPinField(
                      length:      _pinLength,
                      isObscure:   true,
                      isError:     _isError,
                      onCompleted: _onPinCompleted,
                    ),
            ),

            // Message d'erreur
            AnimatedOpacity(
              opacity:  _isError ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: Text(
                  'PIN incorrect. Réessayez.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark ? AppColorsDark.error : AppColors.error,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // ── Liens alternatifs ──────────────────────────────────────
            Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  AppButton.ghost(
                    label:       'Utiliser un autre compte',
                    onPressed:   () => context.go(AppRoutes.login),
                    isFullWidth: true,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.forgotPassword),
                    child: Text(
                      'PIN oublié ?',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isDark ? AppColorsDark.primary : AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
