// =============================================================================
// biometric_setup_page.dart — Activation Biométrie FinTemp
// =============================================================================
// Emplacement : features/auth/presentation/pages/biometric/biometric_setup_page.dart
//
// Propose à l'utilisateur d'activer l'authentification biométrique
// après la création du PIN. Dernier écran du flow d'inscription.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../core/design_system/buttons/app_button.dart';

class BiometricSetupPage extends StatelessWidget {
  const BiometricSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            children: [
              const Spacer(),

              // Illustration biométrie
              _buildIllustration(isDark),

              const SizedBox(height: AppSpacing.x3l),

              Text(
                'Connexion plus rapide',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                'Activez Face ID ou votre empreinte digitale pour vous connecter en un instant.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.x3l),

              // Avantages
              ...[
                (Icons.bolt_rounded, 'Connexion instantanée'),
                (Icons.security_rounded, 'Sécurité renforcée'),
                (Icons.no_accounts_rounded, 'Plus besoin de mot de passe'),
              ].map((item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color:        isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(item.$1,
                        color: isDark ? AppColorsDark.primary : AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      item.$2,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              )),

              const Spacer(),

              AppButton.primary(
                label:     'Activer la biométrie',
                icon:      Icons.fingerprint_rounded,
                onPressed: () => context.go(AppRoutes.kycIntro),
              ),

              const SizedBox(height: AppSpacing.md),

              AppButton.ghost(
                label:       'Pas maintenant',
                onPressed:   () => context.go(AppRoutes.kycIntro),
                isFullWidth: true,
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration(bool isDark) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Cercle externe
        Container(
          width: 180, height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (isDark ? AppColorsDark.primary : AppColors.primary).withAlpha(13),
          ),
        ),
        // Cercle moyen
        Container(
          width: 130, height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (isDark ? AppColorsDark.primary : AppColors.primary).withAlpha(26),
          ),
        ),
        // Icône centrale
        Container(
          width: 90, height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? AppColorsDark.primary : AppColors.primary,
          ),
          child: const Icon(Icons.fingerprint_rounded, color: Colors.white, size: 48),
        ),
      ],
    );
  }
}
