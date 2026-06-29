// =============================================================================
// auth_widgets.dart — Widgets partagés du module Auth FinTemp
// =============================================================================
// Emplacement : features/auth/presentation/widgets/auth_widgets.dart
//
// CONTENU :
//   AuthHeader        → en-tête avec titre + sous-titre
//   AuthSocialButtons → boutons Google / Apple / Facebook
//   AuthDivider       → séparateur "ou"
//   AuthFooterLink    → lien pied de page ("Déjà un compte ? Connexion")
//   AuthPageWrapper   → wrapper scrollable avec SafeArea
// =============================================================================

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_radius.dart';

// =============================================================================
// AuthPageWrapper
// =============================================================================

/// Wrapper standard pour toutes les pages d'auth.
/// Gère : SafeArea, scroll, padding, fond.
class AuthPageWrapper extends StatelessWidget {
  const AuthPageWrapper({
    required this.child,
    this.showBack = true,
    this.onBack,
    super.key,
  });

  final Widget        child;
  final bool          showBack;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bouton retour
              if (showBack) ...[
                GestureDetector(
                  onTap: onBack ?? () => Navigator.of(context).pop(),
                  child: Container(
                    width:  40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColorsDark.inputBackground
                          : AppColors.inputBackground,
                      borderRadius: AppRadius.mdRadius,
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.x2l),
              ] else
                const SizedBox(height: AppSpacing.lg),

              child,
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// AuthHeader
// =============================================================================

/// En-tête titre + sous-titre standard des pages d'auth.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    required this.title,
    this.subtitle,
    super.key,
  });

  final String  title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headlineMedium.copyWith(
            color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle!,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}

// =============================================================================
// AuthDivider
// =============================================================================

/// Séparateur horizontal avec texte "ou" au centre.
class AuthDivider extends StatelessWidget {
  const AuthDivider({this.label = 'ou', super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final divColor = isDark ? AppColorsDark.border : AppColors.border;

    return Row(
      children: [
        Expanded(child: Divider(color: divColor, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
            ),
          ),
        ),
        Expanded(child: Divider(color: divColor, thickness: 1)),
      ],
    );
  }
}

// =============================================================================
// AuthSocialButtons
// =============================================================================

/// Boutons de connexion sociale (Google, Apple).
class AuthSocialButtons extends StatelessWidget {
  const AuthSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: _SocialButton(
            label:   'Google',
            icon:    Icons.g_mobiledata_rounded,
            onTap:   () {},
            isDark:  isDark,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _SocialButton(
            label:   'Apple',
            icon:    Icons.apple_rounded,
            onTap:   () {},
            isDark:  isDark,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  final String       label;
  final IconData     icon;
  final VoidCallback onTap;
  final bool         isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSpacing.buttonHeightMedium,
        decoration: BoxDecoration(
          color:        isDark ? AppColorsDark.inputBackground : AppColors.surface,
          borderRadius: AppRadius.lgRadius,
          border: Border.all(
            color: isDark ? AppColorsDark.border : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size:  22,
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: AppTextStyles.labelLarge.copyWith(
                color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// AuthFooterLink
// =============================================================================

/// Ligne de pied de page avec texte + lien cliquable.
/// Ex: "Déjà un compte ? Connexion"
class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    required this.text,
    required this.linkText,
    required this.onTap,
    super.key,
  });

  final String       text;
  final String       linkText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        GestureDetector(
          onTap: onTap,
          child: Text(
            linkText,
            style: AppTextStyles.bodyMedium.copyWith(
              color:      isDark ? AppColorsDark.primary : AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
