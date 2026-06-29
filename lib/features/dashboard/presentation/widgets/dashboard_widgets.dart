// =============================================================================
// dashboard_widgets.dart — Widgets du Dashboard FinTemp
// =============================================================================
// Emplacement : features/dashboard/presentation/widgets/dashboard_widgets.dart
//
// WIDGETS :
//   MiniBarChart       → graphique à barres compact (12 mois)
//   StatCard           → carte statistique (revenus, dépenses, épargne)
//   SpendingPieChart   → donut chart dépenses par catégorie
// =============================================================================

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_radius.dart';

// =============================================================================
// MiniBarChart — Graphique à barres des dépenses mensuelles
// =============================================================================

class MiniBarChart extends StatelessWidget {
  const MiniBarChart({
    required this.data,
    required this.labels,
    required this.currentIndex,
    required this.isDark,
    super.key,
  });

  final List<double> data;
  final List<String> labels;
  final int          currentIndex;
  final bool         isDark;

  @override
  Widget build(BuildContext context) {
    final maxVal   = data.reduce((a, b) => a > b ? a : b);
    final barCount = data.length;

    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(barCount, (i) {
          final isActive  = i == currentIndex;
          final barHeight = (data[i] / maxVal) * 72;
          final color     = isActive
              ? (isDark ? AppColorsDark.primary : AppColors.primary)
              : (isDark ? AppColorsDark.neutral200 : AppColors.neutral200);

          return Expanded(
            child: GestureDetector(
              onTap: () {}, // Dans une vraie app : sélectionner le mois
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve:    Curves.easeOut,
                      height:   barHeight,
                      decoration: BoxDecoration(
                        color:        color,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// =============================================================================
// StatCard — Carte de statistique (revenus, dépenses, épargne)
// =============================================================================

class StatCard extends StatelessWidget {
  const StatCard({
    required this.label,
    required this.amount,
    required this.currency,
    required this.icon,
    required this.trend,
    required this.trendPositive,
    super.key,
  });

  final String label;
  final double amount;
  final String currency;
  final IconData icon;
  final String trend;
  final bool   trendPositive;

  String _format(double v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000)    return '${(v / 1000).toStringAsFixed(0)}K';
    return v.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final trendColor = trendPositive
        ? (isDark ? AppColorsDark.success : AppColors.success)
        : (isDark ? AppColorsDark.error   : AppColors.error);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color:        isDark ? AppColorsDark.surface : AppColors.surface,
        borderRadius: AppRadius.lgRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color:        isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
                  borderRadius: AppRadius.smRadius,
                ),
                child: Icon(icon, size: 18,
                  color: isDark ? AppColorsDark.primary : AppColors.primary),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color:        trendColor.withAlpha(26),
                  borderRadius: AppRadius.fullRadius,
                ),
                child: Text(trend,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: trendColor, fontWeight: FontWeight.w600,
                  )),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text('${_format(amount)} $currency',
            style: AppTextStyles.titleMedium.copyWith(
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
            )),
          const SizedBox(height: 2),
          Text(label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
            )),
        ],
      ),
    );
  }
}

// =============================================================================
// SpendingPieChart — Donut chart des dépenses par catégorie
// =============================================================================

class SpendingPieChart extends StatelessWidget {
  const SpendingPieChart({
    required this.data,
    super.key,
  });

  final Map<String, double> data;

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final total   = data.values.fold(0.0, (a, b) => a + b);
    final colors  = isDark ? AppColorsDark.chartPalette : AppColors.chartPalette;
    final entries = data.entries.toList();

    return Row(
      children: [
        // Donut
        SizedBox(
          width:  120,
          height: 120,
          child: CustomPaint(
            painter: _DonutPainter(
              values: entries.map((e) => e.value / total).toList(),
              colors: colors,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        // Légende
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(entries.length > 5 ? 5 : entries.length, (i) {
              final pct = (entries[i].value / total * 100).round();
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  children: [
                    Container(
                      width: 10, height: 10,
                      decoration: BoxDecoration(
                        color:  colors[i % colors.length],
                        shape:  BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(entries[i].key,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text('$pct%',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      )),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ── Donut Painter ─────────────────────────────────────────────────────────────

class _DonutPainter extends CustomPainter {
  _DonutPainter({required this.values, required this.colors});
  final List<double> values;
  final List<Color>  colors;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 20.0;
    const gap = 0.03; // espace entre segments

    final paint = Paint()
      ..style     = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startAngle = -1.5707963; // -π/2 (haut)

    for (int i = 0; i < values.length; i++) {
      final sweepAngle = values[i] * 2 * 3.1415926 - gap;
      paint.color = colors[i % colors.length];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += values[i] * 2 * 3.1415926;
    }
  }

  @override
  bool shouldRepaint(_DonutPainter old) =>
      old.values != values || old.colors != colors;
}
