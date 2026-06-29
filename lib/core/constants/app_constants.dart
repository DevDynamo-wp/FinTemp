// =============================================================================
// app_constants.dart — Constantes globales FinTemp
// =============================================================================
// Emplacement : core/constants/app_constants.dart
// =============================================================================

abstract final class AppConstants {
  // ── App ────────────────────────────────────────────────────────────────────
  static const String appName    = 'FinTemp';
  static const String appVersion = '1.0.0';

  // ── Animation durations ────────────────────────────────────────────────────
  static const Duration animFast   = Duration(milliseconds: 150);
  static const Duration animNormal = Duration(milliseconds: 300);
  static const Duration animSlow   = Duration(milliseconds: 500);
  static const Duration splashDuration = Duration(seconds: 2);

  // ── Pagination ─────────────────────────────────────────────────────────────
  static const int pageSize = 20;

  // ── Currency ───────────────────────────────────────────────────────────────
  static const String defaultCurrency = 'FCFA';
  static const String defaultLocale   = 'fr_FR';

  // ── OTP ────────────────────────────────────────────────────────────────────
  static const int otpLength      = 6;
  static const int pinLength      = 4;
  static const int otpExpiresSecs = 120;

  // ── Cards ──────────────────────────────────────────────────────────────────
  static const int cardNumberLength = 16;
  static const int cvvLength        = 3;
}
