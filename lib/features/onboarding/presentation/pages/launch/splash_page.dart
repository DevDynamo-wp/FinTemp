// =============================================================================
// splash_page.dart — Écran Splash FinTemp
// =============================================================================
// Emplacement : features/onboarding/presentation/pages/launch/splash_page.dart
//
// Premier écran affiché au lancement.
// Rôle : afficher la marque + vérifier si l'utilisateur est déjà connecté.
//
// COMPORTEMENT :
//   - Affiche logo + nom pendant 2 secondes
//   - Navigue vers SplashAnimatedPage (qui elle décidera où aller)
//
// DONNÉES : aucune (pas de logique métier)
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../core/constants/app_constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double>   _fadeAnim;
  late Animation<double>   _scaleAnim;

  @override
  void initState() {
    super.initState();

    // Force la status bar transparente sur cet écran
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:      Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Animation d'entrée : fade + scale
    _controller = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve:  Curves.easeOut,
    );

    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    // Navigation après délai
    Future.delayed(AppConstants.splashDuration, _navigate);
  }

  void _navigate() {
    if (!mounted) return;
    // Dans une vraie app : vérifier SharedPreferences pour savoir si
    // l'utilisateur a déjà vu l'onboarding et s'il est connecté.
    // Ici : toujours vers l'onboarding (template)
    context.go(AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond plein — gradient de marque
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.dashboardHeaderGradient,
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Logo ──────────────────────────────────────────────
                    Container(
                      width:  80,
                      height: 80,
                      decoration: BoxDecoration(
                        color:        Colors.white.withAlpha(26),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withAlpha(51),
                          width: 1.5,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'FT',
                          style: TextStyle(
                            color:      Colors.white,
                            fontSize:   28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Nom de l'app ──────────────────────────────────────
                    Text(
                      AppConstants.appName,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color:      Colors.white,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Votre banque, partout.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
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
