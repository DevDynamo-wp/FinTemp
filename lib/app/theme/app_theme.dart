// =============================================================================
// app_theme.dart — Assembleur de thèmes FinTemp
// =============================================================================
// Emplacement : app/theme/app_theme.dart  (conforme au plan)
//
// Point d'entrée unique pour les thèmes.
// Délègue la construction à light_theme.dart et dark_theme.dart.
//
// UTILISATION dans app.dart :
//   theme:     AppTheme.light
//   darkTheme: AppTheme.dark
// =============================================================================

import 'package:flutter/material.dart';

import 'light_theme.dart';
import 'dark_theme.dart';

abstract final class AppTheme {
  /// Thème clair — thème par défaut.
  static ThemeData get light => buildLightTheme();

  /// Thème sombre — activé selon les préférences système ou utilisateur.
  static ThemeData get dark => buildDarkTheme();
}
