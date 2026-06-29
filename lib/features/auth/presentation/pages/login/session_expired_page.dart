// =============================================================================
// session_expired_page.dart — Session Expirée FinTemp
// =============================================================================
// Emplacement : features/auth/presentation/pages/login/session_expired_page.dart
//
// Affiché lorsque la session utilisateur expire.
// Propose de se reconnecter sans perdre le contexte.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../core/design_system/buttons/app_button.dart';
import '../../../../../core/helpers/dummy_data.dart';
import '../../../../../core/widgets/app_avatar.dart';

class SessionExpiredPage extends StatelessWidget {
  const SessionExpiredPage({super.key});

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

              // Icône
              Container(
                width:  88,
                height: 88,
                decoration: BoxDecoration(
                  color:  isDark ? AppColorsDark.warningLight : AppColors.warningLight,
                  shape:  BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_clock_outlined,
                  color: isDark ? AppColorsDark.warning : AppColors.warning,
                  size:  44,
                ),
              ),

              const SizedBox(height: AppSpacing.x2l),

              Text(
                'Session expirée',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Votre session a expiré pour des raisons de sécurité.\nVeuillez vous reconnecter.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.x3l),

              // Avatar + nom
              AppAvatar(initials: DummyData.user.initials, size: AppAvatarSize.lg),
              const SizedBox(height: AppSpacing.sm),
              Text(
                DummyData.user.fullName,
                style: AppTextStyles.titleMedium.copyWith(
                  color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                ),
              ),
              Text(
                DummyData.user.email,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                ),
              ),

              const Spacer(),

              AppButton.primary(
                label:     'Se reconnecter',
                icon:      Icons.login_rounded,
                onPressed: () => context.go(AppRoutes.loginPin),
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton.ghost(
                label:       'Utiliser un autre compte',
                onPressed:   () => context.go(AppRoutes.login),
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
