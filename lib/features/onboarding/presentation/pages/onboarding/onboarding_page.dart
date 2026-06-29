// =============================================================================
// onboarding_page.dart — Onboarding FinTemp (4 slides)
// =============================================================================
// Emplacement : features/onboarding/presentation/pages/onboarding/onboarding_page.dart
//
// Présente les 4 fonctionnalités principales de l'application.
// Chaque slide contient : illustration + titre + description.
//
// FONCTIONNALITÉS :
//   - PageView avec transition fluide
//   - Indicateur de progression (smooth_page_indicator)
//   - Bouton "Passer" (skip) sur toutes les slides sauf la dernière
//   - Bouton "Suivant" → "Commencer" sur la dernière slide
//   - Animation d'entrée de chaque slide
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../app/theme/app_radius.dart';
import '../../../../../core/design_system/buttons/app_button.dart';

// ── Modèle d'une slide ────────────────────────────────────────────────────────

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.title,
    required this.description,
    required this.primaryColor,
    required this.accentColor,
    required this.icon,
    required this.items,
  });
  final String       title;
  final String       description;
  final Color        primaryColor;
  final Color        accentColor;
  final IconData     icon;
  final List<String> items; // Bullet points illustratifs
}

// ── Contenu des slides ────────────────────────────────────────────────────────

const List<_OnboardingSlide> _slides = [
  _OnboardingSlide(
    title:       'Envoyez de l\'argent\ninstantanément',
    description: 'Transférez de l\'argent à vos proches en quelques secondes, partout en Afrique et dans le monde.',
    primaryColor: Color(0xFF1A5C38),
    accentColor:  Color(0xFF22C55E),
    icon:         Icons.send_rounded,
    items: ['Transferts en temps réel', 'Zéro frais sur les premiers envois', '50+ pays supportés'],
  ),
  _OnboardingSlide(
    title:       'Payez en toute\nsécurité',
    description: 'Règlez vos achats en ligne, vos factures et vos commerçants avec votre carte virtuelle ou physique.',
    primaryColor: Color(0xFF3B82F6),
    accentColor:  Color(0xFF60A5FA),
    icon:         Icons.credit_card_rounded,
    items: ['Paiement QR Code', 'Carte Visa/Mastercard', 'Paiement Mobile Money'],
  ),
  _OnboardingSlide(
    title:       'Faites fructifier\nvotre épargne',
    description: 'Créez des objectifs d\'épargne, investissez dans des actions et suivez vos finances en temps réel.',
    primaryColor: Color(0xFFC8962A),
    accentColor:  Color(0xFFE0B254),
    icon:         Icons.trending_up_rounded,
    items: ['Objectifs d\'épargne', 'Investissements BRVM', 'Suivi budgétaire'],
  ),
  _OnboardingSlide(
    title:       'Votre banque\ndans votre poche',
    description: 'Toutes les fonctionnalités d\'une banque moderne, accessibles 24h/24 depuis votre smartphone.',
    primaryColor: Color(0xFF1A5C38),
    accentColor:  Color(0xFF2ECC71),
    icon:         Icons.smartphone_rounded,
    items: ['Sécurité biométrique', 'Support 24/7', 'Disponible hors ligne'],
  ),
];

// =============================================================================
// OnboardingPage
// =============================================================================

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageCtrl = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentPage < _slides.length - 1) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 400),
        curve:    Curves.easeInOut,
      );
    } else {
      _goToWelcome();
    }
  }

  void _goToWelcome() => context.go(AppRoutes.welcome);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLast = _currentPage == _slides.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Barre supérieure ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical:   AppSpacing.lg,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Compteur de page
                  Text(
                    '${_currentPage + 1} / ${_slides.length}',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
                    ),
                  ),
                  // Bouton Passer
                  if (!isLast)
                    GestureDetector(
                      onTap: _goToWelcome,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical:   AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColorsDark.inputBackground
                              : AppColors.inputBackground,
                          borderRadius: AppRadius.fullRadius,
                        ),
                        child: Text(
                          'Passer',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ── Slides ─────────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller:  _pageCtrl,
                itemCount:   _slides.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) => _OnboardingSlideView(
                  slide:      _slides[i],
                  isActive:   i == _currentPage,
                ),
              ),
            ),

            // ── Indicateur + bouton ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.x2l,
              ),
              child: Column(
                children: [
                  // Indicateur de progression
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve:    Curves.easeInOut,
                        margin:   const EdgeInsets.symmetric(horizontal: 4),
                        width:    i == _currentPage ? 24 : 8,
                        height:   8,
                        decoration: BoxDecoration(
                          color: i == _currentPage
                              ? _slides[_currentPage].primaryColor
                              : (isDark ? AppColorsDark.neutral300 : AppColors.neutral300),
                          borderRadius: AppRadius.fullRadius,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.x2l),

                  // Bouton principal
                  AppButton.primary(
                    label:    isLast ? 'Commencer' : 'Suivant',
                    icon:     isLast ? Icons.rocket_launch_rounded : Icons.arrow_forward_rounded,
                    onPressed: _goNext,
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

// =============================================================================
// _OnboardingSlideView — Contenu d'une slide
// =============================================================================

class _OnboardingSlideView extends StatefulWidget {
  const _OnboardingSlideView({
    required this.slide,
    required this.isActive,
  });

  final _OnboardingSlide slide;
  final bool             isActive;

  @override
  State<_OnboardingSlideView> createState() => _OnboardingSlideViewState();
}

class _OnboardingSlideViewState extends State<_OnboardingSlideView>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset>   _slideAnim;
  late Animation<double>   _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end:   Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

    if (widget.isActive) _ctrl.forward();
  }

  @override
  void didUpdateWidget(_OnboardingSlideView old) {
    super.didUpdateWidget(old);
    if (widget.isActive && !old.isActive) {
      _ctrl
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Padding(
          padding: AppSpacing.screenPaddingH,
          child: Column(
            children: [
              // ── Illustration ─────────────────────────────────────────
              Expanded(
                flex: 5,
                child: _buildIllustration(isDark),
              ),

              const SizedBox(height: AppSpacing.x2l),

              // ── Texte ─────────────────────────────────────────────────
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.slide.title,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    Text(
                      widget.slide.description,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.x2l),

                    // Bullet points
                    ...widget.slide.items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Row(
                          children: [
                            Container(
                              width:  20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: widget.slide.primaryColor.withAlpha(26),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: widget.slide.primaryColor,
                                size:  12,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              item,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration(bool isDark) {
    return Center(
      child: Container(
        width:  240,
        height: 240,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:   Alignment.bottomRight,
            colors: [
              widget.slide.primaryColor.withAlpha(26),
              widget.slide.accentColor.withAlpha(13),
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Cercle secondaire décoratif
            Container(
              width:  180,
              height: 180,
              decoration: BoxDecoration(
                color:  widget.slide.primaryColor.withAlpha(20),
                shape:  BoxShape.circle,
              ),
            ),
            // Icône principale
            Container(
              width:  120,
              height: 120,
              decoration: BoxDecoration(
                color:  widget.slide.primaryColor,
                shape:  BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color:      widget.slide.primaryColor.withAlpha(77),
                    blurRadius: 32,
                    offset:     const Offset(0, 12),
                  ),
                ],
              ),
              child: Icon(
                widget.slide.icon,
                color: Colors.white,
                size:  52,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
