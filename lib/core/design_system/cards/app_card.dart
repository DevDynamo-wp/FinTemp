// =============================================================================
// app_card.dart — Composant Carte FinTemp
// =============================================================================
// Emplacement : core/design_system/cards/app_card.dart
//
// VARIANTES :
//   AppCard           → carte standard avec ombre légère
//   AppCard.outlined  → carte avec bordure, sans ombre
//   AppCard.filled    → carte avec fond coloré (primarySurface)
//   AppCard.flat      → carte sans ombre ni bordure (sections de page)
// =============================================================================

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_shadows.dart';

// ── Variantes ─────────────────────────────────────────────────────────────────

enum _CardVariant { standard, outlined, filled, flat }

// =============================================================================
// AppCard
// =============================================================================

/// Carte générique du Design System FinTemp.
///
/// Exemples :
/// ```dart
/// // Carte standard (ombre légère)
/// AppCard(child: Text('Contenu'))
///
/// // Carte outline
/// AppCard.outlined(child: SomeWidget())
///
/// // Carte fond coloré
/// AppCard.filled(child: SomeWidget())
///
/// // Carte cliquable
/// AppCard(onTap: () {}, child: SomeWidget())
/// ```
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.width,
    this.height,
    super.key,
  }) : _variant = _CardVariant.standard;

  const AppCard.outlined({
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.width,
    this.height,
    super.key,
  }) : _variant = _CardVariant.outlined;

  const AppCard.filled({
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.width,
    this.height,
    super.key,
  }) : _variant = _CardVariant.filled;

  const AppCard.flat({
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.width,
    this.height,
    super.key,
  }) : _variant = _CardVariant.flat;

  final Widget        child;
  final VoidCallback? onTap;
  final EdgeInsets?   padding;
  final EdgeInsets?   margin;
  final BorderRadius? borderRadius;
  final double?       width;
  final double?       height;
  final _CardVariant  _variant;

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final radius  = borderRadius ?? AppRadius.card;
    final effectivePadding = padding ?? AppSpacing.cardPadding;

    final bgColor = switch (_variant) {
      _CardVariant.standard => isDark ? AppColorsDark.surface         : AppColors.surface,
      _CardVariant.outlined => isDark ? AppColorsDark.surface         : AppColors.surface,
      _CardVariant.filled   => isDark ? AppColorsDark.primarySurface  : AppColors.primarySurface,
      _CardVariant.flat     => isDark ? AppColorsDark.surface         : AppColors.surface,
    };

    final shadows = switch (_variant) {
      _CardVariant.standard => isDark ? AppShadowsDark.sm : AppShadows.sm,
      _CardVariant.outlined => <BoxShadow>[],
      _CardVariant.filled   => <BoxShadow>[],
      _CardVariant.flat     => <BoxShadow>[],
    };

    final border = switch (_variant) {
      _CardVariant.outlined => Border.all(
          color: isDark ? AppColorsDark.border : AppColors.border,
        ),
      _ => null,
    };

    Widget content = Container(
      width:  width,
      height: height,
      margin: margin,
      padding: effectivePadding,
      decoration: BoxDecoration(
        color:        bgColor,
        borderRadius: radius,
        boxShadow:    shadows,
        border:       border,
      ),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color:        Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap:        onTap,
          borderRadius: radius,
          splashColor:  (isDark ? AppColorsDark.primary : AppColors.primary).withAlpha(20),
          child: content,
        ),
      );
    }

    return content;
  }
}
