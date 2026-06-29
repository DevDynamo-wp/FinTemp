// =============================================================================
// app_badge.dart — Composant Badge FinTemp
// =============================================================================
// Emplacement : core/design_system/badges/app_badge.dart
//
// VARIANTES :
//   AppBadge.success  → vert  (transaction réussie, statut actif)
//   AppBadge.error    → rouge (transaction échouée, carte bloquée)
//   AppBadge.warning  → orange (en attente, expiration proche)
//   AppBadge.info     → bleu  (information neutre)
//   AppBadge.neutral  → gris  (statut inactif)
//   AppBadge.primary  → vert principal (tag de feature)
//
// TAILLES :
//   AppBadgeSize.small  → 20px (dans les listes, tuiles)
//   AppBadgeSize.medium → 24px (cards, headers)
//   AppBadgeSize.large  → 28px (pages de détail)
// =============================================================================

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_radius.dart';

// ── Variantes ─────────────────────────────────────────────────────────────────

enum AppBadgeVariant { success, error, warning, info, neutral, primary }
enum AppBadgeSize    { small, medium, large }

// =============================================================================
// AppBadge
// =============================================================================

/// Badge d'état ou de statut.
///
/// ```dart
/// AppBadge.success(label: 'Réussi')
/// AppBadge.error(label: 'Échoué')
/// AppBadge.warning(label: 'En attente')
/// AppBadge(label: 'KYC Vérifié', variant: AppBadgeVariant.primary)
/// ```
class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.label,
    this.variant = AppBadgeVariant.neutral,
    this.size    = AppBadgeSize.medium,
    this.icon,
    super.key,
  });

  factory AppBadge.success({required String label, AppBadgeSize size = AppBadgeSize.medium, Key? key}) =>
      AppBadge(label: label, variant: AppBadgeVariant.success, size: size, key: key);

  factory AppBadge.error({required String label, AppBadgeSize size = AppBadgeSize.medium, Key? key}) =>
      AppBadge(label: label, variant: AppBadgeVariant.error, size: size, key: key);

  factory AppBadge.warning({required String label, AppBadgeSize size = AppBadgeSize.medium, Key? key}) =>
      AppBadge(label: label, variant: AppBadgeVariant.warning, size: size, key: key);

  factory AppBadge.info({required String label, AppBadgeSize size = AppBadgeSize.medium, Key? key}) =>
      AppBadge(label: label, variant: AppBadgeVariant.info, size: size, key: key);

  final String         label;
  final AppBadgeVariant variant;
  final AppBadgeSize   size;
  final IconData?      icon;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = _resolveColors(isDark);

    final textStyle = switch (size) {
      AppBadgeSize.small  => AppTextStyles.labelSmall,
      AppBadgeSize.medium => AppTextStyles.labelMedium,
      AppBadgeSize.large  => AppTextStyles.labelLarge,
    };

    final vPad = switch (size) {
      AppBadgeSize.small  => 2.0,
      AppBadgeSize.medium => 4.0,
      AppBadgeSize.large  => 6.0,
    };

    final hPad = switch (size) {
      AppBadgeSize.small  => 6.0,
      AppBadgeSize.medium => 8.0,
      AppBadgeSize.large  => 10.0,
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color:        colors.background,
        borderRadius: AppRadius.fullRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: colors.foreground),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: textStyle.copyWith(color: colors.foreground),
          ),
        ],
      ),
    );
  }

  _BadgeColors _resolveColors(bool isDark) {
    switch (variant) {
      case AppBadgeVariant.success:
        return _BadgeColors(
          background: isDark ? AppColorsDark.successLight : AppColors.successLight,
          foreground: isDark ? AppColorsDark.successDark  : AppColors.successDark,
        );
      case AppBadgeVariant.error:
        return _BadgeColors(
          background: isDark ? AppColorsDark.errorLight : AppColors.errorLight,
          foreground: isDark ? AppColorsDark.errorDark  : AppColors.errorDark,
        );
      case AppBadgeVariant.warning:
        return _BadgeColors(
          background: isDark ? AppColorsDark.warningLight : AppColors.warningLight,
          foreground: isDark ? AppColorsDark.warningDark  : AppColors.warningDark,
        );
      case AppBadgeVariant.info:
        return _BadgeColors(
          background: isDark ? AppColorsDark.infoLight : AppColors.infoLight,
          foreground: isDark ? AppColorsDark.infoDark  : AppColors.infoDark,
        );
      case AppBadgeVariant.primary:
        return _BadgeColors(
          background: isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
          foreground: isDark ? AppColorsDark.primary        : AppColors.primary,
        );
      case AppBadgeVariant.neutral:
        return _BadgeColors(
          background: isDark ? AppColorsDark.neutral200 : AppColors.neutral200,
          foreground: isDark ? AppColorsDark.neutral600  : AppColors.neutral600,
        );
    }
  }
}

// =============================================================================
// NotificationBadge — Badge rouge avec compteur (ex: 3 notifications)
// =============================================================================

/// Badge circulaire rouge avec un chiffre.
/// Utilisé sur les icônes de notification dans la nav bar.
///
/// ```dart
/// Stack(children: [
///   Icon(Icons.notifications_outlined),
///   Positioned(
///     right: 0, top: 0,
///     child: NotificationBadge(count: 3),
///   ),
/// ])
/// ```
class NotificationBadge extends StatelessWidget {
  const NotificationBadge({
    required this.count,
    this.max = 99,
    super.key,
  });

  final int count;
  final int max;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final display = count > max ? '$max+' : '$count';

    return Container(
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color:        isDark ? AppColorsDark.error : AppColors.error,
        borderRadius: AppRadius.fullRadius,
      ),
      child: Text(
        display,
        style: AppTextStyles.labelSmall.copyWith(
          color:    AppColors.white,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ── Internal ──────────────────────────────────────────────────────────────────

class _BadgeColors {
  const _BadgeColors({required this.background, required this.foreground});
  final Color background;
  final Color foreground;
}
