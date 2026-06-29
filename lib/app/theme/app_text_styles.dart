// =============================================================================
// app_text_styles.dart — Typographie FinTemp
// =============================================================================
// Emplacement : app/theme/app_text_styles.dart  (conforme au plan)
//
// POLICE : Plus Jakarta Sans
//   Moderne, géométrique, excellente lisibilité sur mobile.
//   Supporte les chiffres tabulaires — indispensable pour une Fintech.
//
// RÈGLE : Ne jamais écrire de TextStyle inline dans les widgets.
//         Toujours utiliser AppTextStyles.xxx
//
// ÉCHELLE COMPLÈTE (Material 3 + variants Fintech) :
//   display   → grands montants, écrans hero
//   headline  → titres de pages et sections
//   title     → en-têtes de composants
//   body      → corps de texte
//   label     → boutons, badges, actions
//   [fintech] → montants, OTP, numéro de carte, IBAN
// =============================================================================

import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  static const String _font        = 'PlusJakartaSans';
  static const String _fontNumeric = 'PlusJakartaSans';

  // ── Display ────────────────────────────────────────────────────────────────

  /// 57sp Bold — Montants héroïques, splash financier.
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _fontNumeric,
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.5,
    height: 1.12,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// 45sp Bold — Montant principal du dashboard mis en avant.
  static const TextStyle displayMedium = TextStyle(
    fontFamily: _fontNumeric,
    fontSize: 45,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.0,
    height: 1.16,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// 36sp SemiBold — Solde principal, montant de transfert.
  static const TextStyle displaySmall = TextStyle(
    fontFamily: _fontNumeric,
    fontSize: 36,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 1.22,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // ── Headline ───────────────────────────────────────────────────────────────

  /// 32sp Bold — Titre d'écran principal.
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _font,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.25,
  );

  /// 28sp SemiBold — Titre de section majeure.
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _font,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
    height: 1.29,
  );

  /// 24sp SemiBold — Titre de carte ou modal.
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _font,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
    height: 1.33,
  );

  // ── Title ──────────────────────────────────────────────────────────────────

  /// 22sp SemiBold — En-tête de liste, bottom sheet.
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _font,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.27,
  );

  /// 16sp SemiBold — Titre de carte, nom de bénéficiaire.
  static const TextStyle titleMedium = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  );

  /// 14sp SemiBold — Label d'input, titre de cellule.
  static const TextStyle titleSmall = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  // ── Body ───────────────────────────────────────────────────────────────────

  /// 16sp Regular — Corps de texte principal.
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.5,
  );

  /// 14sp Regular — Texte secondaire, description de transaction.
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  /// 12sp Regular — Texte de support, métadonnées, dates.
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _font,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // ── Label ──────────────────────────────────────────────────────────────────

  /// 14sp SemiBold — Texte de bouton principal.
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  /// 12sp Medium — Badge, chip, tag.
  static const TextStyle labelMedium = TextStyle(
    fontFamily: _font,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  );

  /// 11sp Medium — Micro-labels, mentions légales.
  static const TextStyle labelSmall = TextStyle(
    fontFamily: _font,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );

  // ── Fintech Variants ───────────────────────────────────────────────────────

  /// Montant medium dans les listes de transactions.
  static const TextStyle amountMedium = TextStyle(
    fontFamily: _fontNumeric,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.5,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Montant small dans les sous-éléments.
  static const TextStyle amountSmall = TextStyle(
    fontFamily: _fontNumeric,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    height: 1.43,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Code OTP / PIN — grands chiffres espacés.
  static const TextStyle otpCode = TextStyle(
    fontFamily: _fontNumeric,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 8,
    height: 1.2,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Numéro de carte bancaire masqué / affiché.
  static const TextStyle cardNumber = TextStyle(
    fontFamily: _fontNumeric,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 4,
    height: 1.4,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// IBAN — espacement caractéristique.
  static const TextStyle iban = TextStyle(
    fontFamily: _fontNumeric,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 2,
    height: 1.5,
  );

  /// Pourcentage — taux d'intérêt, variations.
  static const TextStyle percentage = TextStyle(
    fontFamily: _fontNumeric,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.43,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // ── Helper ─────────────────────────────────────────────────────────────────

  /// Génère un TextTheme Material 3 complet pour AppTheme.
  static TextTheme toTextTheme({required Color defaultColor}) {
    return TextTheme(
      displayLarge:   displayLarge.copyWith(color: defaultColor),
      displayMedium:  displayMedium.copyWith(color: defaultColor),
      displaySmall:   displaySmall.copyWith(color: defaultColor),
      headlineLarge:  headlineLarge.copyWith(color: defaultColor),
      headlineMedium: headlineMedium.copyWith(color: defaultColor),
      headlineSmall:  headlineSmall.copyWith(color: defaultColor),
      titleLarge:     titleLarge.copyWith(color: defaultColor),
      titleMedium:    titleMedium.copyWith(color: defaultColor),
      titleSmall:     titleSmall.copyWith(color: defaultColor),
      bodyLarge:      bodyLarge.copyWith(color: defaultColor),
      bodyMedium:     bodyMedium.copyWith(color: defaultColor),
      bodySmall:      bodySmall.copyWith(color: defaultColor),
      labelLarge:     labelLarge.copyWith(color: defaultColor),
      labelMedium:    labelMedium.copyWith(color: defaultColor),
      labelSmall:     labelSmall.copyWith(color: defaultColor),
    );
  }
}
