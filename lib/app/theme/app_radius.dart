// =============================================================================
// app_radius.dart — Rayons de bordure FinTemp
// =============================================================================
// Emplacement : app/theme/app_radius.dart  (conforme au plan)
// =============================================================================

import 'package:flutter/material.dart';

abstract final class AppRadius {
  // ── Valeurs scalaires ──────────────────────────────────────────────────────
  static const double none = 0;
  static const double xs   = 4;
  static const double sm   = 8;
  static const double md   = 12;
  static const double lg   = 16;
  static const double xl   = 20;
  static const double x2l  = 24;
  static const double x3l  = 32;
  static const double full = 999;

  // ── BorderRadius objects ───────────────────────────────────────────────────
  static const BorderRadius noneRadius = BorderRadius.zero;
  static const BorderRadius xsRadius   = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius smRadius   = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdRadius   = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgRadius   = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlRadius   = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius x2lRadius  = BorderRadius.all(Radius.circular(x2l));
  static const BorderRadius x3lRadius  = BorderRadius.all(Radius.circular(x3l));
  static const BorderRadius fullRadius = BorderRadius.all(Radius.circular(full));

  // ── Aliases sémantiques ────────────────────────────────────────────────────

  /// Rayon d'un bouton standard.
  static const BorderRadius button = lgRadius;

  /// Rayon d'un champ de saisie.
  static const BorderRadius input = mdRadius;

  /// Rayon d'une carte.
  static const BorderRadius card = lgRadius;

  /// Rayon d'une carte bancaire.
  static const BorderRadius bankCard = x3lRadius;

  /// Rayon d'un bottom sheet (top only).
  static BorderRadius get bottomSheet => const BorderRadius.only(
    topLeft:  Radius.circular(x2l),
    topRight: Radius.circular(x2l),
  );

  /// Rayon d'un dialog.
  static const BorderRadius dialog = xlRadius;

  /// Rayon d'un badge / chip.
  static const BorderRadius badge = xsRadius;

  /// Rayon d'un avatar.
  static const BorderRadius avatar = fullRadius;

  // ── Radius objects (pour ShapeDecoration) ─────────────────────────────────
  static const Radius smR   = Radius.circular(sm);
  static const Radius mdR   = Radius.circular(md);
  static const Radius lgR   = Radius.circular(lg);
  static const Radius xlR   = Radius.circular(xl);
  static const Radius fullR = Radius.circular(full);
}