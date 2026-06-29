// =============================================================================
// transaction_tile.dart — Tuile Transaction FinTemp
// =============================================================================
// Emplacement : core/widgets/transaction_tile.dart
//
// Composant de liste affichant une transaction.
// Utilisé dans :
//   - Dashboard (transactions récentes)
//   - Historique (liste complète)
//   - Wallet (historique wallet)
//   - Cards (historique carte)
//
// VARIANTES :
//   TransactionTile          → tuile standard (liste)
//   TransactionTile.compact  → version compacte (dashboard)
// =============================================================================

import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';
import '../app/theme/app_text_styles.dart';
import '../app/theme/app_spacing.dart';
import '../app/theme/app_radius.dart';
import '../core/design_system/badges/app_badge.dart';
import '../core/enums/app_enums.dart';

// =============================================================================
// TransactionTile
// =============================================================================

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.status,
    this.category,
    this.onTap,
    this.showStatus = false,
    super.key,
  }) : _isCompact = false;

  const TransactionTile.compact({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.status,
    this.category,
    this.onTap,
    super.key,
  }) : _isCompact = true,
       showStatus = false;

  final String            title;
  final String            subtitle;
  final double            amount;
  final DateTime          date;
  final TransactionType   type;
  final TransactionStatus status;
  final String?           category;
  final VoidCallback?     onTap;
  final bool              showStatus;
  final bool              _isCompact;

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final isIncome = type == TransactionType.income;

    final amountColor = switch (status) {
      TransactionStatus.failed    => isDark ? AppColorsDark.error   : AppColors.error,
      TransactionStatus.cancelled => isDark ? AppColorsDark.neutral500 : AppColors.neutral500,
      _ => isIncome
          ? (isDark ? AppColorsDark.success  : AppColors.success)
          : (isDark ? AppColorsDark.textPrimary : AppColors.textPrimary),
    };

    final amountPrefix = isIncome ? '+' : '-';
    final formattedAmount = _formatAmount(amount.abs());

    return Material(
      color:        Colors.transparent,
      borderRadius: AppRadius.mdRadius,
      child: InkWell(
        onTap:        onTap,
        borderRadius: AppRadius.mdRadius,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _isCompact ? 0 : AppSpacing.lg,
            vertical: _isCompact ? AppSpacing.sm : AppSpacing.md,
          ),
          child: Row(
            children: [
              // Icône catégorie
              _CategoryIcon(
                category: category ?? _defaultCategory,
                type:     type,
                isDark:   isDark,
                isCompact: _isCompact,
              ),

              const SizedBox(width: AppSpacing.md),

              // Titre + sous-titre
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleSmall.copyWith(
                        color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _isCompact ? subtitle : '$subtitle · ${_formatDate(date)}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              // Montant + statut
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$amountPrefix$formattedAmount',
                    style: AppTextStyles.amountMedium.copyWith(
                      color: amountColor,
                    ),
                  ),
                  if (showStatus) ...[
                    const SizedBox(height: 4),
                    _StatusBadge(status: status),
                  ] else ...[
                    const SizedBox(height: 2),
                    Text(
                      _formatTime(date),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _defaultCategory {
    return switch (type) {
      TransactionType.income   => 'Revenus',
      TransactionType.expense  => 'Dépenses',
      TransactionType.transfer => 'Transfert',
    };
  }

  String _formatAmount(double value) {
    final parts = value.toStringAsFixed(0).split('').reversed.toList();
    final buffer = StringBuffer();
    for (int i = 0; i < parts.length; i++) {
      if (i > 0 && i % 3 == 0) buffer.write('\u202F');
      buffer.write(parts[i]);
    }
    return '${buffer.toString().split('').reversed.join()} FCFA';
  }

  String _formatDate(DateTime date) {
    final now  = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'Aujourd\'hui';
    if (diff.inDays == 1) return 'Hier';
    final months = ['jan.','fév.','mar.','avr.','mai','jun.',
                    'jul.','aoû.','sep.','oct.','nov.','déc.'];
    return '${date.day} ${months[date.month - 1]}';
  }

  String _formatTime(DateTime date) {
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

// ── Icône catégorie ───────────────────────────────────────────────────────────

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({
    required this.category,
    required this.type,
    required this.isDark,
    required this.isCompact,
  });

  final String          category;
  final TransactionType type;
  final bool            isDark;
  final bool            isCompact;

  @override
  Widget build(BuildContext context) {
    final size = isCompact ? 40.0 : 46.0;

    final (bgColor, fgColor, icon) = _resolveStyle();

    return Container(
      width:  size,
      height: size,
      decoration: BoxDecoration(
        color:        bgColor,
        borderRadius: AppRadius.mdRadius,
      ),
      child: Icon(icon, color: fgColor, size: size * 0.45),
    );
  }

  (Color, Color, IconData) _resolveStyle() {
    // Couleur selon type de transaction
    if (type == TransactionType.income) {
      return (
        isDark ? AppColorsDark.successLight : AppColors.successLight,
        isDark ? AppColorsDark.success      : AppColors.success,
        Icons.arrow_downward_rounded,
      );
    }
    if (type == TransactionType.transfer) {
      return (
        isDark ? AppColorsDark.infoLight : AppColors.infoLight,
        isDark ? AppColorsDark.info      : AppColors.info,
        Icons.swap_horiz_rounded,
      );
    }

    // Icône selon catégorie pour les dépenses
    final icon = switch (category.toLowerCase()) {
      String c when c.contains('ali')  => Icons.restaurant_outlined,
      String c when c.contains('log')  => Icons.home_outlined,
      String c when c.contains('tran') => Icons.directions_car_outlined,
      String c when c.contains('san')  => Icons.medical_services_outlined,
      String c when c.contains('loi')  => Icons.movie_outlined,
      String c when c.contains('fac')  => Icons.receipt_outlined,
      String c when c.contains('mob')  => Icons.smartphone_outlined,
      String c when c.contains('inv')  => Icons.trending_up_outlined,
      _                                => Icons.arrow_upward_rounded,
    };

    return (
      isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
      isDark ? AppColorsDark.primary        : AppColors.primary,
      icon,
    );
  }
}

// ── Badge statut ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final TransactionStatus status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      TransactionStatus.completed => AppBadge.success(
          label: 'Réussi',
          size:  AppBadgeSize.small,
        ),
      TransactionStatus.pending => AppBadge.warning(
          label: 'En attente',
          size:  AppBadgeSize.small,
        ),
      TransactionStatus.failed => AppBadge.error(
          label: 'Échoué',
          size:  AppBadgeSize.small,
        ),
      TransactionStatus.cancelled => AppBadge(
          label:   'Annulé',
          variant: AppBadgeVariant.neutral,
          size:    AppBadgeSize.small,
        ),
    };
  }
}
