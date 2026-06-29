// =============================================================================
// app_spacing.dart — Espacements FinTemp
// =============================================================================
// Emplacement : app/theme/app_spacing.dart  (conforme au plan)
//
// Grille 4pt : toutes les valeurs sont des multiples de 4.
// Garantit une cohérence visuelle parfaite sur tous les écrans.
// =============================================================================

import 'package:flutter/material.dart';

abstract final class AppSpacing {
  // ── Échelle de base ────────────────────────────────────────────────────────
  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 12;
  static const double lg  = 16;
  static const double xl  = 20;
  static const double x2l = 24;
  static const double x3l = 32;
  static const double x4l = 40;
  static const double x5l = 48;
  static const double x6l = 56;
  static const double x7l = 64;

  // ── Screen ─────────────────────────────────────────────────────────────────
  static const double screenHorizontal = lg;
  static const double screenVertical   = x2l;

  static const EdgeInsets screenPaddingH = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
  );
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
    vertical: screenVertical,
  );

  // ── Card ───────────────────────────────────────────────────────────────────
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets cardPaddingCompact = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  // ── Button ─────────────────────────────────────────────────────────────────
  static const EdgeInsets buttonLarge  = EdgeInsets.symmetric(horizontal: x2l, vertical: lg);
  static const EdgeInsets buttonMedium = EdgeInsets.symmetric(horizontal: xl,  vertical: md);
  static const EdgeInsets buttonSmall  = EdgeInsets.symmetric(horizontal: lg,  vertical: sm);

  // ── Input ──────────────────────────────────────────────────────────────────
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(horizontal: lg, vertical: lg);

  // ── Heights fixes ──────────────────────────────────────────────────────────
  static const double buttonHeightLarge  = 56;
  static const double buttonHeightMedium = 48;
  static const double buttonHeightSmall  = 36;
  static const double inputHeight        = 56;
  static const double bottomNavHeight    = 72;
  static const double minTapTarget       = 48;
  static const double transactionTileH   = 72;
  static const double walletCardHeight   = 180;
  static const double bankCardHeight     = 200;
  static const double appBarHeight       = 56;
}
