// =============================================================================
// app_loading.dart — Composants de chargement FinTemp
// =============================================================================
// Emplacement : core/design_system/loading/app_loading.dart
//
// COMPOSANTS :
//   AppShimmer              → effet shimmer générique sur n'importe quel widget
//   ShimmerTransactionTile  → squelette de transaction
//   ShimmerWalletCard       → squelette de la carte de solde
//   ShimmerBankCard         → squelette d'une carte bancaire
//   AppLoadingIndicator     → spinner centré
// =============================================================================

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_radius.dart';

// =============================================================================
// AppShimmer — Effet de chargement animé
// =============================================================================

/// Enveloppe n'importe quel widget avec un effet shimmer de chargement.
///
/// ```dart
/// AppShimmer(child: Container(width: 200, height: 20))
/// ```
class AppShimmer extends StatefulWidget {
  const AppShimmer({required this.child, super.key});
  final Widget child;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double>   _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => ShaderMask(
        blendMode:    BlendMode.srcATop,
        shaderCallback: (bounds) => LinearGradient(
          begin:  Alignment.centerLeft,
          end:    Alignment.centerRight,
          stops: const [0.0, 0.5, 1.0],
          colors: [
            isDark ? AppColorsDark.shimmerBase      : AppColors.shimmerBase,
            isDark ? AppColorsDark.shimmerHighlight : AppColors.shimmerHighlight,
            isDark ? AppColorsDark.shimmerBase      : AppColors.shimmerBase,
          ],
          transform: _SlidingGradientTransform(_animation.value),
        ).createShader(bounds),
        child: widget.child,
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform(this.slidePercent);
  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}

// =============================================================================
// _ShimmerBox — Boîte shimmer rectangulaire
// =============================================================================

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.width,
    required this.height,
    this.borderRadius,
  });

  final double        width;
  final double        height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width:  width,
      height: height,
      decoration: BoxDecoration(
        color:        isDark ? AppColorsDark.shimmerBase : AppColors.shimmerBase,
        borderRadius: borderRadius ?? AppRadius.smRadius,
      ),
    );
  }
}

// =============================================================================
// Skeletons
// =============================================================================

/// Squelette d'une tuile de transaction.
class ShimmerTransactionTile extends StatelessWidget {
  const ShimmerTransactionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical:   AppSpacing.md,
        ),
        child: Row(
          children: [
            // Icône
            _ShimmerBox(width: 46, height: 46, borderRadius: AppRadius.mdRadius),
            const SizedBox(width: AppSpacing.md),
            // Texte
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShimmerBox(width: 140, height: 14),
                  const SizedBox(height: 8),
                  _ShimmerBox(width: 100, height: 12),
                ],
              ),
            ),
            // Montant
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _ShimmerBox(width: 80, height: 14),
                const SizedBox(height: 8),
                _ShimmerBox(width: 50, height: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Squelette de la WalletCard.
class ShimmerWalletCard extends StatelessWidget {
  const ShimmerWalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        width:  double.infinity,
        height: AppSpacing.walletCardHeight,
        decoration: BoxDecoration(
          color:        AppColors.shimmerBase,
          borderRadius: AppRadius.xlRadius,
        ),
      ),
    );
  }
}

/// Squelette d'une carte bancaire.
class ShimmerBankCard extends StatelessWidget {
  const ShimmerBankCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        width:  double.infinity,
        height: AppSpacing.bankCardHeight,
        decoration: BoxDecoration(
          color:        AppColors.shimmerBase,
          borderRadius: AppRadius.bankCard,
        ),
      ),
    );
  }
}

// =============================================================================
// AppLoadingIndicator — Spinner centré
// =============================================================================

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    this.size  = 36,
    this.color,
    super.key,
  });

  final double  size;
  final Color?  color;

  @override
  Widget build(BuildContext context) {
    final isDark     = Theme.of(context).brightness == Brightness.dark;
    final spinColor  = color ?? (isDark ? AppColorsDark.primary : AppColors.primary);

    return Center(
      child: SizedBox(
        width:  size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color:       spinColor,
        ),
      ),
    );
  }
}
