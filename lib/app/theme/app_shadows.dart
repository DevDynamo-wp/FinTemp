// =============================================================================
// app_shadows.dart — Ombres FinTemp
// =============================================================================
// Emplacement : app/theme/app_shadows.dart  (conforme au plan)
// =============================================================================

import 'package:flutter/material.dart';

// ── Light Mode ────────────────────────────────────────────────────────────────

abstract final class AppShadows {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> sm = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 4,  offset: Offset(0, 1)),
    BoxShadow(color: Color(0x06000000), blurRadius: 2,  offset: Offset(0, 1)),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4)),
    BoxShadow(color: Color(0x0A000000), blurRadius: 4,  offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(color: Color(0x1F000000), blurRadius: 24, offset: Offset(0, 8)),
    BoxShadow(color: Color(0x0F000000), blurRadius: 8,  offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(color: Color(0x29000000), blurRadius: 40, offset: Offset(0, 16)),
    BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6)),
  ];

  // Ombres colorées — effet premium
  static const List<BoxShadow> primaryGlow = [
    BoxShadow(color: Color(0x401A5C38), blurRadius: 20, offset: Offset(0, 8)),
  ];

  static const List<BoxShadow> secondaryGlow = [
    BoxShadow(color: Color(0x40C8962A), blurRadius: 20, offset: Offset(0, 8)),
  ];

  static const List<BoxShadow> errorGlow = [
    BoxShadow(color: Color(0x33EF4444), blurRadius: 16, offset: Offset(0, 6)),
  ];

  // Ombre de la carte bancaire — effet lévitation
  static const List<BoxShadow> bankCard = [
    BoxShadow(color: Color(0x331A5C38), blurRadius: 32, offset: Offset(0, 16)),
    BoxShadow(color: Color(0x14000000), blurRadius: 8,  offset: Offset(0, 4)),
  ];
}

// ── Dark Mode ─────────────────────────────────────────────────────────────────

abstract final class AppShadowsDark {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> sm = [
    BoxShadow(color: Color(0x29000000), blurRadius: 4,  offset: Offset(0, 1)),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(color: Color(0x3D000000), blurRadius: 12, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(color: Color(0x52000000), blurRadius: 24, offset: Offset(0, 8)),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(color: Color(0x66000000), blurRadius: 40, offset: Offset(0, 16)),
  ];

  static const List<BoxShadow> primaryGlow = [
    BoxShadow(color: Color(0x662ECC71), blurRadius: 20, offset: Offset(0, 8)),
  ];

  static const List<BoxShadow> bankCard = [
    BoxShadow(color: Color(0x802ECC71), blurRadius: 32, offset: Offset(0, 16)),
  ];
}