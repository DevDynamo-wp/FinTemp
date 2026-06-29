// =============================================================================
// wallet_card.dart — Widget Portefeuille FinTemp
// =============================================================================
// Emplacement : core/widgets/wallet_card.dart
//
// Carte affichant le solde principal de l'utilisateur.
// Utilisée sur le Dashboard et l'écran Wallet.
//
// FONCTIONNALITÉS :
//   - Affichage / masquage du solde (toggle)
//   - Gradient de marque
//   - Actions rapides : Envoyer · Recevoir · Recharger
//   - Animation de reveal du solde
//   - Support Light / Dark (gradient identique, comportement cohérent)
// =============================================================================

import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';
import '../app/theme/app_text_styles.dart';
import '../app/theme/app_spacing.dart';
import '../app/theme/app_radius.dart';
import '../app/theme/app_shadows.dart';

// =============================================================================
// WalletCard
// =============================================================================

/// Carte principale du solde utilisateur.
///
/// ```dart
/// WalletCard(
///   balance:      847200,
///   currency:     'FCFA',
///   ownerName:    'Kofi Mensah',
///   onSend:       () {},
///   onReceive:    () {},
///   onTopUp:      () {},
/// )
/// ```
class WalletCard extends StatefulWidget {
  const WalletCard({
    required this.balance,
    required this.currency,
    required this.ownerName,
    this.onSend,
    this.onReceive,
    this.onTopUp,
    this.initiallyVisible = true,
    super.key,
  });

  final double        balance;
  final String        currency;
  final String        ownerName;
  final VoidCallback? onSend;
  final VoidCallback? onReceive;
  final VoidCallback? onTopUp;
  final bool          initiallyVisible;

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard>
    with SingleTickerProviderStateMixin {
  late bool               _isVisible;
  late AnimationController _controller;
  late Animation<double>   _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.initiallyVisible;
    _controller = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 300),
      value:    _isVisible ? 1.0 : 0.0,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve:  Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() => _isVisible = !_isVisible);
    if (_isVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  String _formatBalance(double value) {
    // Séparateur de milliers manuel (compatible sans dépendance)
    final parts = value.toStringAsFixed(0).split('').reversed.toList();
    final buffer = StringBuffer();
    for (int i = 0; i < parts.length; i++) {
      if (i > 0 && i % 3 == 0) buffer.write('\u202F'); // espace fine
      buffer.write(parts[i]);
    }
    return buffer.toString().split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  double.infinity,
      height: AppSpacing.walletCardHeight,
      decoration: BoxDecoration(
        gradient:     AppColors.cardGradient,
        borderRadius: AppRadius.xlRadius,
        boxShadow:    AppShadows.bankCard,
      ),
      child: Stack(
        children: [
          // ── Motifs décoratifs (cercles semi-transparents) ────────────────
          Positioned(
            right:  -30,
            top:    -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(13), // 5% opacité
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -50,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(10), // 4% opacité
              ),
            ),
          ),

          // ── Contenu ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.x2l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ligne haute : label + toggle visibilité
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Solde disponible',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white.withAlpha(179), // 70%
                      ),
                    ),
                    GestureDetector(
                      onTap: _toggleVisibility,
                      child: Icon(
                        _isVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.white.withAlpha(179),
                        size: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.sm),

                // Montant principal
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: child,
                  ),
                  child: _isVisible
                      ? Row(
                          key: const ValueKey('visible'),
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              _formatBalance(widget.balance),
                              style: AppTextStyles.displaySmall.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              widget.currency,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: Colors.white.withAlpha(179),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          key: const ValueKey('hidden'),
                          children: [
                            Text(
                              '••••••',
                              style: AppTextStyles.displaySmall.copyWith(
                                color: Colors.white,
                                letterSpacing: 4,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              widget.currency,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: Colors.white.withAlpha(179),
                              ),
                            ),
                          ],
                        ),
                ),

                const Spacer(),

                // Ligne basse : nom + actions rapides
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.ownerName.toUpperCase(),
                      style: AppTextStyles.labelMedium.copyWith(
                        color: Colors.white.withAlpha(179),
                        letterSpacing: 1.5,
                      ),
                    ),
                    Row(
                      children: [
                        _QuickAction(
                          icon:    Icons.arrow_upward_rounded,
                          label:   'Envoyer',
                          onTap:   widget.onSend,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        _QuickAction(
                          icon:    Icons.arrow_downward_rounded,
                          label:   'Recevoir',
                          onTap:   widget.onReceive,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        _QuickAction(
                          icon:    Icons.add,
                          label:   'Recharger',
                          onTap:   widget.onTopUp,
                        ),
                      ],
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
}

// ── Action rapide (bouton icône sur la carte) ─────────────────────────────────

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData      icon;
  final String        label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width:  36,
            height: 36,
            decoration: BoxDecoration(
              color:  Colors.white.withAlpha(38), // 15%
              shape:  BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color:    Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
