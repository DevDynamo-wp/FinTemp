// =============================================================================
// bank_card_widget.dart — Widget Carte Bancaire FinTemp
// =============================================================================
// Emplacement : core/widgets/bank_card_widget.dart
//
// Affiche une carte bancaire avec :
//   - Ratio standard 85.6mm × 54mm
//   - Numéro masqué / affiché
//   - Logo réseau (Visa / Mastercard)
//   - Gradient selon le type (standard / gold / blocked)
//   - Animation flip recto/verso
// =============================================================================

import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../app/theme/app_colors.dart';
import '../app/theme/app_text_styles.dart';
import '../app/theme/app_spacing.dart';
import '../app/theme/app_radius.dart';
import '../app/theme/app_shadows.dart';

// ── Types de carte ────────────────────────────────────────────────────────────

enum BankCardStyle { standard, gold, dark, blocked }
enum CardNetworkLogo { visa, mastercard, amex }

// =============================================================================
// BankCardWidget
// =============================================================================

/// Widget affichant une carte bancaire avec animation flip.
///
/// ```dart
/// BankCardWidget(
///   cardNumber:  '4582',
///   holderName:  'KOFI MENSAH',
///   expiryDate:  '12/27',
///   network:     CardNetworkLogo.visa,
///   style:       BankCardStyle.standard,
/// )
/// ```
class BankCardWidget extends StatefulWidget {
  const BankCardWidget({
    required this.lastFourDigits,
    required this.holderName,
    required this.expiryDate,
    required this.network,
    this.style      = BankCardStyle.standard,
    this.isFlippable = false,
    this.cvv,
    super.key,
  });

  final String          lastFourDigits;
  final String          holderName;
  final String          expiryDate;
  final CardNetworkLogo network;
  final BankCardStyle   style;
  final bool            isFlippable;
  final String?         cvv;

  @override
  State<BankCardWidget> createState() => _BankCardWidgetState();
}

class _BankCardWidgetState extends State<BankCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double>   _animation;
  bool _showBack = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    if (!widget.isFlippable) return;
    if (_showBack) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => _showBack = !_showBack);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isFlippable) return _buildFront();

    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          final angle = _animation.value * math.pi;
          final isBack = angle > math.pi / 2;

          return Transform(
            alignment:  Alignment.center,
            transform:  Matrix4.rotationY(angle),
            child: isBack
                ? Transform(
                    alignment:  Alignment.center,
                    transform:  Matrix4.rotationY(math.pi),
                    child:      _buildBack(),
                  )
                : _buildFront(),
          );
        },
      ),
    );
  }

  // ── Face avant ─────────────────────────────────────────────────────────────

  Widget _buildFront() {
    final gradient = switch (widget.style) {
      BankCardStyle.standard => AppColors.cardGradient,
      BankCardStyle.gold     => AppColors.cardGradientGold,
      BankCardStyle.dark     => const LinearGradient(
          begin: Alignment.topLeft,
          end:   Alignment.bottomRight,
          colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
        ),
      BankCardStyle.blocked  => const LinearGradient(
          begin: Alignment.topLeft,
          end:   Alignment.bottomRight,
          colors: [Color(0xFF8E8E93), Color(0xFF636366)],
        ),
    };

    return Container(
      width:  double.infinity,
      height: AppSpacing.bankCardHeight,
      decoration: BoxDecoration(
        gradient:     gradient,
        borderRadius: AppRadius.bankCard,
        boxShadow:    widget.style == BankCardStyle.blocked
            ? AppShadows.sm
            : AppShadows.bankCard,
      ),
      child: Stack(
        children: [
          // Motifs décoratifs
          _buildDecorations(),

          // Contenu
          Padding(
            padding: const EdgeInsets.all(AppSpacing.x2l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ligne haute : logo banque + logo réseau
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'FinTemp',
                      style: AppTextStyles.titleMedium.copyWith(
                        color:    Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _buildNetworkLogo(),
                  ],
                ),

                const Spacer(),

                // Puce / chip
                Container(
                  width:  40,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD4AF37), Color(0xFFF0D060)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Numéro de carte
                Text(
                  '**** **** **** ${widget.lastFourDigits}',
                  style: AppTextStyles.cardNumber.copyWith(color: Colors.white),
                ),

                const SizedBox(height: AppSpacing.md),

                // Ligne basse : nom + expiration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Titulaire',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.white.withAlpha(153),
                          ),
                        ),
                        Text(
                          widget.holderName,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Expiration',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.white.withAlpha(153),
                          ),
                        ),
                        Text(
                          widget.expiryDate,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Badge "Bloquée"
          if (widget.style == BankCardStyle.blocked)
            Positioned(
              top:   AppSpacing.lg,
              right: AppSpacing.lg,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical:   AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color:        Colors.white.withAlpha(51),
                  borderRadius: AppRadius.fullRadius,
                ),
                child: Text(
                  'BLOQUÉE',
                  style: AppTextStyles.labelSmall.copyWith(
                    color:    Colors.white,
                    fontSize: 10,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Face arrière ───────────────────────────────────────────────────────────

  Widget _buildBack() {
    return Container(
      width:  double.infinity,
      height: AppSpacing.bankCardHeight,
      decoration: BoxDecoration(
        color:        const Color(0xFF1A5C38),
        borderRadius: AppRadius.bankCard,
        boxShadow:    AppShadows.bankCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bande magnétique
          const SizedBox(height: AppSpacing.x2l),
          Container(
            width:  double.infinity,
            height: 44,
            color:  const Color(0xFF0D0D0D),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.x2l, 0, AppSpacing.x2l, AppSpacing.x2l,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'CVV',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white.withAlpha(153),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical:   AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color:        Colors.white,
                        borderRadius: AppRadius.xsRadius,
                      ),
                      child: Text(
                        widget.cvv ?? '•••',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: const Color(0xFF0D0D0D),
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Logo réseau ────────────────────────────────────────────────────────────

  Widget _buildNetworkLogo() {
    switch (widget.network) {
      case CardNetworkLogo.visa:
        return Text(
          'VISA',
          style: AppTextStyles.titleMedium.copyWith(
            color:    Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        );
      case CardNetworkLogo.mastercard:
        return SizedBox(
          width: 44,
          height: 28,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  width:  28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color:  Color(0xFFEB001B),
                    shape:  BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width:  28,
                  height: 28,
                  decoration: BoxDecoration(
                    color:  const Color(0xFFF79E1B).withAlpha(220),
                    shape:  BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        );
      case CardNetworkLogo.amex:
        return Text(
          'AMEX',
          style: AppTextStyles.labelLarge.copyWith(
            color:    Colors.white,
            letterSpacing: 2,
          ),
        );
    }
  }

  // ── Décorations ────────────────────────────────────────────────────────────

  Widget _buildDecorations() {
    return Stack(
      children: [
        Positioned(
          right: -40,
          top:   -40,
          child: Container(
            width:  160,
            height: 160,
            decoration: BoxDecoration(
              shape:  BoxShape.circle,
              color:  Colors.white.withAlpha(13),
            ),
          ),
        ),
        Positioned(
          right:  30,
          bottom: -60,
          child: Container(
            width:  120,
            height: 120,
            decoration: BoxDecoration(
              shape:  BoxShape.circle,
              color:  Colors.white.withAlpha(8),
            ),
          ),
        ),
      ],
    );
  }
}
