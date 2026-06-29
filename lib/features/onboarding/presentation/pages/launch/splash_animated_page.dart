// =============================================================================
// splash_animated_page.dart — Splash Animé FinTemp
// =============================================================================
// Emplacement : features/onboarding/presentation/pages/launch/splash_animated_page.dart
//
// Deuxième écran splash, avec une animation plus riche.
// Peut être utilisé comme transition entre le splash statique
// et le premier écran réel (onboarding ou login).
//
// ANIMATION :
//   - Barre de progression circulaire
//   - Texte de chargement animé ("Chargement...", "Sécurisation...", etc.)
//   - Fade-out à la fin
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';

class SplashAnimatedPage extends StatefulWidget {
  const SplashAnimatedPage({super.key});

  @override
  State<SplashAnimatedPage> createState() => _SplashAnimatedPageState();
}

class _SplashAnimatedPageState extends State<SplashAnimatedPage>
    with TickerProviderStateMixin {

  late AnimationController _progressController;
  late AnimationController _textController;
  late Animation<double>   _progressAnim;
  late Animation<double>   _textFadeAnim;

  int _loadingStep = 0;
  final List<String> _loadingTexts = [
    'Initialisation...',
    'Sécurisation...',
    'Chargement...',
    'Presque prêt...',
  ];

  @override
  void initState() {
    super.initState();

    // Progression circulaire : 0 → 1 en 2.5 secondes
    _progressController = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 2500),
    );
    _progressAnim = CurvedAnimation(
      parent: _progressController,
      curve:  Curves.easeInOut,
    );

    // Texte : fade in/out
    _textController = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 300),
    );
    _textFadeAnim = CurvedAnimation(
      parent: _textController,
      curve:  Curves.easeOut,
    );

    _textController.forward();
    _progressController.forward().then((_) => _navigate());

    // Changer le texte toutes les 600ms
    _scheduleTextUpdates();
  }

  void _scheduleTextUpdates() {
    for (int i = 1; i < _loadingTexts.length; i++) {
      Future.delayed(Duration(milliseconds: 600 * i), () {
        if (!mounted) return;
        _textController.reverse().then((_) {
          if (!mounted) return;
          setState(() => _loadingStep = i);
          _textController.forward();
        });
      });
    }
  }

  void _navigate() {
    if (!mounted) return;
    context.go(AppRoutes.languageSelect);
  }

  @override
  void dispose() {
    _progressController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.dashboardHeaderGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),

              // ── Logo central ───────────────────────────────────────────
              _buildLogo(),

              const Spacer(),

              // ── Indicateur de progression ──────────────────────────────
              _buildProgressSection(),

              const SizedBox(height: AppSpacing.x4l),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Cercle animé autour du logo
        AnimatedBuilder(
          animation: _progressAnim,
          builder: (_, child) => Stack(
            alignment: Alignment.center,
            children: [
              // Cercle de progression
              SizedBox(
                width:  100,
                height: 100,
                child: CircularProgressIndicator(
                  value:       _progressAnim.value,
                  color:       Colors.white.withAlpha(230),
                  backgroundColor: Colors.white.withAlpha(51),
                  strokeWidth: 2,
                ),
              ),
              // Logo
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
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.x2l),

        Text(
          'FinTemp',
          style: AppTextStyles.headlineMedium.copyWith(
            color:      Colors.white,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Texte de chargement animé
        FadeTransition(
          opacity: _textFadeAnim,
          child: Text(
            _loadingTexts[_loadingStep],
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white.withAlpha(179),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Barre de progression linéaire
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.x4l),
          child: AnimatedBuilder(
            animation: _progressAnim,
            builder: (_, __) => ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value:            _progressAnim.value,
                backgroundColor:  Colors.white.withAlpha(51),
                valueColor:       const AlwaysStoppedAnimation(Colors.white),
                minHeight:        3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
