// =============================================================================
// welcome_page.dart — Page de Bienvenue FinTemp
// =============================================================================
// Emplacement : features/onboarding/presentation/pages/launch/welcome_page.dart
//
// Dernier écran du flow de lancement, avant l'onboarding.
// Accueille l'utilisateur avec un visuel fort et 2 actions :
//   → Créer un compte
//   → J'ai déjà un compte (connexion)
//
// C'est souvent l'écran que les acheteurs de templates présentent
// dans leurs previews — il doit être visuellement impactant.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../app/theme/app_radius.dart';
import '../../../../../core/design_system/buttons/app_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size   = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Fond avec gradient ─────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.dashboardHeaderGradient,
            ),
          ),

          // ── Motifs décoratifs ──────────────────────────────────────
          Positioned(
            right: -60,
            top:   size.height * 0.05,
            child: Container(
              width:  260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(10),
              ),
            ),
          ),
          Positioned(
            left:  -80,
            top:   size.height * 0.20,
            child: Container(
              width:  200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(8),
              ),
            ),
          ),

          // ── Illustration centrale ──────────────────────────────────
          Positioned(
            top:   size.height * 0.08,
            left:  0,
            right: 0,
            child: _buildIllustration(size),
          ),

          // ── Contenu bas de page ────────────────────────────────────
          Positioned(
            bottom: 0,
            left:   0,
            right:  0,
            child: _buildBottomContent(context, isDark),
          ),
        ],
      ),
    );
  }

  // ── Illustration (mockup de l'app) ────────────────────────────────────────

  Widget _buildIllustration(Size size) {
    return Center(
      child: SizedBox(
        height: size.height * 0.52,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Mockup téléphone arrière-plan (légèrement décalé)
            Positioned(
              right: size.width * 0.08,
              top:   30,
              child: Transform.rotate(
                angle: 0.1,
                child: _PhoneMockup(opacity: 0.5),
              ),
            ),
            // Mockup téléphone principal
            Positioned(
              left:  size.width * 0.08,
              top:   0,
              child: _PhoneMockup(opacity: 1.0),
            ),
          ],
        ),
      ),
    );
  }

  // ── Zone inférieure ────────────────────────────────────────────────────────

  Widget _buildBottomContent(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.x3l,
        AppSpacing.lg,
        AppSpacing.x2l + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color:        isDark ? AppColorsDark.background : const Color(0xFFF8FBF9),
        borderRadius: const BorderRadius.only(
          topLeft:  Radius.circular(AppRadius.x3l),
          topRight: Radius.circular(AppRadius.x3l),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Titre
          Text(
            'Gérez votre argent\ncomme un pro',
            style: AppTextStyles.headlineMedium.copyWith(
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            'Envoyez, recevez et investissez votre argent en toute sécurité, depuis votre téléphone.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: AppSpacing.x3l),

          // Bouton principal
          AppButton.primary(
            label:     'Créer un compte',
            onPressed: () => context.go(AppRoutes.register),
          ),

          const SizedBox(height: AppSpacing.md),

          // Bouton secondaire
          AppButton.secondary(
            label:     'J\'ai déjà un compte',
            onPressed: () => context.go(AppRoutes.login),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Mentions légales
          Center(
            child: Text(
              'En continuant, vous acceptez nos Conditions d\'utilisation\net notre Politique de confidentialité.',
              style: AppTextStyles.labelSmall.copyWith(
                color: isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mockup téléphone ──────────────────────────────────────────────────────────

class _PhoneMockup extends StatelessWidget {
  const _PhoneMockup({required this.opacity});
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width:  160,
        height: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:   Alignment.bottomRight,
            colors: [
              Colors.white.withAlpha(31),
              Colors.white.withAlpha(10),
            ],
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.white.withAlpha(51),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            // Barre de statut mockup
            Container(
              height:      28,
              decoration: BoxDecoration(
                color:        Colors.white.withAlpha(13),
                borderRadius: const BorderRadius.only(
                  topLeft:  Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Éléments d'interface simulés
            _MockupLine(width: 100, height: 10),
            const SizedBox(height: 8),
            _MockupLine(width: 130, height: 32, radius: 12),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MockupLine(width: 60, height: 60, radius: 12),
                  _MockupLine(width: 60, height: 60, radius: 12),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _MockupLine(width: 130, height: 12),
            const SizedBox(height: 6),
            _MockupLine(width: 100, height: 10),
            const SizedBox(height: 12),
            _MockupLine(width: 130, height: 48, radius: 12),
          ],
        ),
      ),
    );
  }
}

class _MockupLine extends StatelessWidget {
  const _MockupLine({
    required this.width,
    required this.height,
    this.radius = 4,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  width,
      height: height,
      decoration: BoxDecoration(
        color:        Colors.white.withAlpha(38),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
