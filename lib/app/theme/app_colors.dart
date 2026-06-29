// =============================================================================
// app_colors.dart — Palette de couleurs FinTemp
// =============================================================================
// Emplacement : app/theme/app_colors.dart  (conforme au plan)
//
// RÈGLE ABSOLUE : Aucune couleur ne doit être écrite directement dans
// un widget. Toujours utiliser AppColors.xxx
//
// PALETTE :
//   Couleur primaire  : Vert foncé #1A5C38  (identité Fintech africaine)
//   Couleur secondaire: Or        #C8962A  (accent premium)
//   Inspiré du design system visible dans les maquettes fournies.
// =============================================================================

import 'package:flutter/material.dart';

// =============================================================================
// LIGHT MODE
// =============================================================================

abstract final class AppColors {
  // ── Brand ──────────────────────────────────────────────────────────────────
  static const Color primary        = Color(0xFF1A5C38);
  static const Color primaryLight   = Color(0xFF246B43);
  static const Color primarySurface = Color(0xFFE8F5ED);
  static const Color primaryDark    = Color(0xFF124028);

  static const Color secondary        = Color(0xFFC8962A);
  static const Color secondarySurface = Color(0xFFFAF3E2);

  // ── Neutrals ───────────────────────────────────────────────────────────────
  static const Color neutral900 = Color(0xFF0D0D0D);
  static const Color neutral800 = Color(0xFF1C1C1E);
  static const Color neutral700 = Color(0xFF3A3A3C);
  static const Color neutral600 = Color(0xFF636366);
  static const Color neutral500 = Color(0xFF8E8E93);
  static const Color neutral400 = Color(0xFFAEAEB2);
  static const Color neutral300 = Color(0xFFC7C7CC);
  static const Color neutral200 = Color(0xFFE5E5EA);
  static const Color neutral100 = Color(0xFFF2F2F7);
  static const Color neutral50  = Color(0xFFFAFAFA);
  static const Color white      = Color(0xFFFFFFFF);

  // ── Semantic ───────────────────────────────────────────────────────────────
  static const Color success      = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color successDark  = Color(0xFF16A34A);

  static const Color error      = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark  = Color(0xFFDC2626);

  static const Color warning      = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark  = Color(0xFFD97706);

  static const Color info      = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  static const Color infoDark  = Color(0xFF2563EB);

  // ── Surfaces ───────────────────────────────────────────────────────────────
  static const Color background      = Color(0xFFF5F5F7);
  static const Color surface         = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFFF0F0F5);
  static const Color overlay         = Color(0x80000000);
  static const Color shimmerBase      = Color(0xFFE8E8EE);
  static const Color shimmerHighlight = Color(0xFFF5F5FA);

  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF636366);
  static const Color textTertiary  = Color(0xFF8E8E93);
  static const Color textDisabled  = Color(0xFFAEAEB2);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textLink      = Color(0xFF1A5C38);

  // ── Borders ────────────────────────────────────────────────────────────────
  static const Color border       = Color(0xFFE5E5EA);
  static const Color borderFocus  = Color(0xFF1A5C38);
  static const Color borderError  = Color(0xFFEF4444);
  static const Color divider      = Color(0xFFF0F0F5);

  // ── Charts ─────────────────────────────────────────────────────────────────
  static const Color chart1 = Color(0xFF1A5C38);
  static const Color chart2 = Color(0xFF22C55E);
  static const Color chart3 = Color(0xFFC8962A);
  static const Color chart4 = Color(0xFF3B82F6);
  static const Color chart5 = Color(0xFFEF4444);
  static const Color chart6 = Color(0xFF8B5CF6);

  static const List<Color> chartPalette = [
    chart1, chart2, chart3, chart4, chart5, chart6,
  ];

  // ── Gradients ──────────────────────────────────────────────────────────────
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A5C38), Color(0xFF0D3D24)],
  );

  static const LinearGradient cardGradientGold = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC8962A), Color(0xFF8B6318)],
  );

  static const LinearGradient dashboardHeaderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1A5C38), Color(0xFF246B43)],
  );
}

// =============================================================================
// DARK MODE
// =============================================================================

abstract final class AppColorsDark {
  // ── Brand ──────────────────────────────────────────────────────────────────
  static const Color primary        = Color(0xFF2ECC71);
  static const Color primaryLight   = Color(0xFF3DD67E);
  static const Color primarySurface = Color(0xFF1A3D28);
  static const Color primaryDark    = Color(0xFF27AE60);

  static const Color secondary        = Color(0xFFE0B254);
  static const Color secondarySurface = Color(0xFF3D2E10);

  // ── Neutrals ───────────────────────────────────────────────────────────────
  static const Color neutral900 = Color(0xFFF2F2F7);
  static const Color neutral800 = Color(0xFFE5E5EA);
  static const Color neutral700 = Color(0xFFC7C7CC);
  static const Color neutral600 = Color(0xFFAEAEB2);
  static const Color neutral500 = Color(0xFF8E8E93);
  static const Color neutral400 = Color(0xFF636366);
  static const Color neutral300 = Color(0xFF3A3A3C);
  static const Color neutral200 = Color(0xFF2C2C2E);
  static const Color neutral100 = Color(0xFF1C1C1E);
  static const Color neutral50  = Color(0xFF141414);
  static const Color white      = Color(0xFFFFFFFF);

  // ── Semantic ───────────────────────────────────────────────────────────────
  static const Color success      = Color(0xFF4ADE80);
  static const Color successLight = Color(0xFF14532D);
  static const Color successDark  = Color(0xFF22C55E);

  static const Color error      = Color(0xFFF87171);
  static const Color errorLight = Color(0xFF450A0A);
  static const Color errorDark  = Color(0xFFEF4444);

  static const Color warning      = Color(0xFFFBBF24);
  static const Color warningLight = Color(0xFF451A03);
  static const Color warningDark  = Color(0xFFF59E0B);

  static const Color info      = Color(0xFF60A5FA);
  static const Color infoLight = Color(0xFF172554);
  static const Color infoDark  = Color(0xFF3B82F6);

  // ── Surfaces ───────────────────────────────────────────────────────────────
  static const Color background      = Color(0xFF0D0D0D);
  static const Color surface         = Color(0xFF1C1C1E);
  static const Color inputBackground = Color(0xFF2C2C2E);
  static const Color overlay         = Color(0x99000000);
  static const Color shimmerBase      = Color(0xFF2C2C2E);
  static const Color shimmerHighlight = Color(0xFF3A3A3C);

  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFFF2F2F7);
  static const Color textSecondary = Color(0xFFAEAEB2);
  static const Color textTertiary  = Color(0xFF8E8E93);
  static const Color textDisabled  = Color(0xFF636366);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textLink      = Color(0xFF2ECC71);

  // ── Borders ────────────────────────────────────────────────────────────────
  static const Color border      = Color(0xFF3A3A3C);
  static const Color borderFocus = Color(0xFF2ECC71);
  static const Color borderError = Color(0xFFF87171);
  static const Color divider     = Color(0xFF2C2C2E);

  // ── Charts ─────────────────────────────────────────────────────────────────
  static const Color chart1 = Color(0xFF2ECC71);
  static const Color chart2 = Color(0xFF4ADE80);
  static const Color chart3 = Color(0xFFE0B254);
  static const Color chart4 = Color(0xFF60A5FA);
  static const Color chart5 = Color(0xFFF87171);
  static const Color chart6 = Color(0xFFA78BFA);

  static const List<Color> chartPalette = [
    chart1, chart2, chart3, chart4, chart5, chart6,
  ];

  // ── Gradients ──────────────────────────────────────────────────────────────
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A5C38), Color(0xFF0D3D24)],
  );

  static const LinearGradient cardGradientGold = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC8962A), Color(0xFF8B6318)],
  );

  static const LinearGradient dashboardHeaderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1A5C38), Color(0xFF124028)],
  );
}