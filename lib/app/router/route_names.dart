// =============================================================================
// route_names.dart — Noms de routes FinTemp
// =============================================================================
// Emplacement : app/router/route_names.dart  (conforme au plan)
//
// Centralise TOUS les chemins de navigation.
// Ne jamais écrire de chemin en dur dans les widgets.
//
// UTILISATION :
//   context.go(AppRoutes.dashboard);
//   context.push(AppRoutes.login);
// =============================================================================

abstract final class AppRoutes {
  // ── Lancement ──────────────────────────────────────────────────────────────
  static const String splash       = '/';
  static const String splashAnimated = '/splash-animated';
  static const String languageSelect = '/language';
  static const String countrySelect  = '/country';
  static const String welcome        = '/welcome';

  // ── Onboarding ─────────────────────────────────────────────────────────────
  static const String onboarding = '/onboarding';

  // ── Auth — Connexion ───────────────────────────────────────────────────────
  static const String login          = '/auth/login';
  static const String loginBiometric = '/auth/login/biometric';
  static const String loginPin       = '/auth/login/pin';
  static const String loginOtp       = '/auth/login/otp';
  static const String sessionExpired = '/auth/session-expired';

  // ── Auth — Inscription ─────────────────────────────────────────────────────
  static const String register         = '/auth/register';
  static const String verifyEmail      = '/auth/verify/email';
  static const String verifyPhone      = '/auth/verify/phone';
  static const String verifyOtp        = '/auth/verify/otp';
  static const String createPassword   = '/auth/password/create';
  static const String confirmPassword  = '/auth/password/confirm';

  // ── Auth — Mot de passe oublié ─────────────────────────────────────────────
  static const String forgotPassword  = '/auth/password/forgot';
  static const String forgotOtp       = '/auth/password/forgot/otp';
  static const String resetPassword   = '/auth/password/reset';
  static const String resetSuccess    = '/auth/password/success';

  // ── Auth — Sécurité ────────────────────────────────────────────────────────
  static const String createPin   = '/auth/pin/create';
  static const String confirmPin  = '/auth/pin/confirm';
  static const String biometric   = '/auth/biometric';

  // ── KYC ────────────────────────────────────────────────────────────────────
  static const String kycIntro        = '/kyc';
  static const String kycDocument     = '/kyc/document';
  static const String kycDocumentFront = '/kyc/document/front';
  static const String kycDocumentBack  = '/kyc/document/back';
  static const String kycSelfie       = '/kyc/selfie';
  static const String kycPending      = '/kyc/pending';
  static const String kycSuccess      = '/kyc/success';
  static const String kycFailed       = '/kyc/failed';
  static const String kycResubmit     = '/kyc/resubmit';
  static const String kycProofAddress = '/kyc/proof-address';
  static const String kycPersonalInfo = '/kyc/personal-info';
  static const String kycSummary      = '/kyc/summary';

  // ── Home Shell ─────────────────────────────────────────────────────────────
  static const String home = '/home';

  // ── Dashboard ──────────────────────────────────────────────────────────────
  static const String dashboard          = '/home/dashboard';
  static const String dashboardBalanceHidden  = '/home/dashboard/balance-hidden';
  static const String dashboardBalanceShown   = '/home/dashboard/balance-shown';
  static const String dashboardMultiAccount   = '/home/dashboard/multi-account';
  static const String dashboardSavings        = '/home/dashboard/savings';
  static const String dashboardCurrencies     = '/home/dashboard/currencies';
  static const String dashboardCharts         = '/home/dashboard/charts';
  static const String dashboardWidgets        = '/home/dashboard/widgets';

  // ── Cartes bancaires ───────────────────────────────────────────────────────
  static const String cards            = '/home/cards';
  static const String cardVirtual      = '/home/cards/virtual';
  static const String cardPhysical     = '/home/cards/physical';
  static const String cardDetail       = '/home/cards/detail';
  static const String cardBlock        = '/home/cards/block';
  static const String cardUnblock      = '/home/cards/unblock';
  static const String cardChangePin    = '/home/cards/change-pin';
  static const String cardLimits       = '/home/cards/limits';
  static const String cardHistory      = '/home/cards/history';
  static const String cardAdd          = '/home/cards/add';
  static const String cardOrder        = '/home/cards/order';
  static const String cardSuccess      = '/home/cards/success';

  // ── Wallet ─────────────────────────────────────────────────────────────────
  static const String wallet          = '/home/wallet';
  static const String walletTopUp     = '/home/wallet/topup';
  static const String walletWithdraw  = '/home/wallet/withdraw';
  static const String walletHistory   = '/home/wallet/history';
  static const String walletBalance   = '/home/wallet/balance';
  static const String walletReceive   = '/home/wallet/receive';
  static const String walletQr        = '/home/wallet/qr';
  static const String walletStats     = '/home/wallet/stats';

  // ── Paiements ──────────────────────────────────────────────────────────────
  static const String payments               = '/home/payments';
  static const String paymentQr              = '/home/payments/qr';
  static const String paymentScanQr          = '/home/payments/scan-qr';
  static const String paymentMerchant        = '/home/payments/merchant';
  static const String paymentBill            = '/home/payments/bill';
  static const String paymentMobileMoney     = '/home/payments/mobile-money';
  static const String paymentCard            = '/home/payments/card';
  static const String paymentInternational   = '/home/payments/international';
  static const String paymentConfirmation    = '/home/payments/confirm';
  static const String paymentSuccess         = '/home/payments/success';
  static const String paymentFailed          = '/home/payments/failed';
  static const String paymentReceipt         = '/home/payments/receipt';
  static const String paymentShareReceipt    = '/home/payments/share-receipt';
  static const String paymentScheduled       = '/home/payments/scheduled';
  static const String paymentRecurring       = '/home/payments/recurring';

  // ── Transferts ─────────────────────────────────────────────────────────────
  static const String transfers             = '/home/transfers';
  static const String transferBetweenAccounts = '/home/transfers/between-accounts';
  static const String transferToContact     = '/home/transfers/to-contact';
  static const String transferToBank        = '/home/transfers/to-bank';
  static const String transferInternational = '/home/transfers/international';
  static const String transferAddBeneficiary = '/home/transfers/add-beneficiary';
  static const String transferBeneficiaries = '/home/transfers/beneficiaries';
  static const String transferSearch        = '/home/transfers/search';
  static const String transferConfirmation  = '/home/transfers/confirm';
  static const String transferSuccess       = '/home/transfers/success';
  static const String transferFailed        = '/home/transfers/failed';
  static const String transferReceipt       = '/home/transfers/receipt';
  static const String transferScheduled     = '/home/transfers/scheduled';
  static const String transferRecurring     = '/home/transfers/recurring';
  static const String transferHistory       = '/home/transfers/history';

  // ── Historique ─────────────────────────────────────────────────────────────
  static const String history            = '/home/history';
  static const String historyIncoming    = '/home/history/incoming';
  static const String historyOutgoing    = '/home/history/outgoing';
  static const String historyFilters     = '/home/history/filters';
  static const String historySearch      = '/home/history/search';
  static const String historyDetail      = '/home/history/detail';
  static const String historyDownload    = '/home/history/download';
  static const String historyExport      = '/home/history/export';

  // ── Notifications ──────────────────────────────────────────────────────────
  static const String notifications           = '/home/notifications';
  static const String notificationDetail      = '/home/notifications/detail';
  static const String notificationPromotions  = '/home/notifications/promotions';
  static const String notificationSecurity    = '/home/notifications/security';
  static const String notificationSettings    = '/home/notifications/settings';

  // ── Statistiques ───────────────────────────────────────────────────────────
  static const String statistics         = '/home/statistics';
  static const String statisticsExpenses = '/home/statistics/expenses';
  static const String statisticsIncome   = '/home/statistics/income';
  static const String statisticsCharts   = '/home/statistics/charts';
  static const String statisticsCategories = '/home/statistics/categories';
  static const String statisticsBudget   = '/home/statistics/budget';
  static const String statisticsGoals    = '/home/statistics/goals';

  // ── Épargne ────────────────────────────────────────────────────────────────
  static const String savings            = '/home/savings';
  static const String savingsNew         = '/home/savings/new';
  static const String savingsDetail      = '/home/savings/detail';
  static const String savingsDeposit     = '/home/savings/deposit';
  static const String savingsWithdraw    = '/home/savings/withdraw';
  static const String savingsGoalReached = '/home/savings/goal-reached';
  static const String savingsHistory     = '/home/savings/history';

  // ── Investissements ────────────────────────────────────────────────────────
  static const String investments        = '/home/investments';
  static const String investmentStocks   = '/home/investments/stocks';
  static const String investmentCrypto   = '/home/investments/crypto';
  static const String investmentFunds    = '/home/investments/funds';
  static const String investmentDetail   = '/home/investments/detail';
  static const String investmentPerformance = '/home/investments/performance';

  // ── Crédit / Prêt ──────────────────────────────────────────────────────────
  static const String loans              = '/home/loans';
  static const String loanSimulator      = '/home/loans/simulator';
  static const String loanAmount         = '/home/loans/amount';
  static const String loanDocuments      = '/home/loans/documents';
  static const String loanValidation     = '/home/loans/validation';
  static const String loanApproved       = '/home/loans/approved';
  static const String loanSchedule       = '/home/loans/schedule';
  static const String loanHistory        = '/home/loans/history';

  // ── Profil ─────────────────────────────────────────────────────────────────
  static const String profile              = '/home/profile';
  static const String profileEdit          = '/home/profile/edit';
  static const String profilePhoto         = '/home/profile/photo';
  static const String profileAddress       = '/home/profile/address';
  static const String profilePersonalInfo  = '/home/profile/personal-info';
  static const String profileDocuments     = '/home/profile/documents';
  static const String profilePreferences   = '/home/profile/preferences';
  static const String profileLanguage      = '/home/profile/language';
  static const String profileCountry       = '/home/profile/country';
  static const String profileLogout        = '/home/profile/logout';

  // ── Paramètres ─────────────────────────────────────────────────────────────
  static const String settings             = '/home/settings';
  static const String settingsAppearance   = '/home/settings/appearance';
  static const String settingsDarkMode     = '/home/settings/dark-mode';
  static const String settingsSecurity     = '/home/settings/security';
  static const String settingsChangePassword = '/home/settings/change-password';
  static const String settingsChangePin    = '/home/settings/change-pin';
  static const String settingsBiometric    = '/home/settings/biometric';
  static const String settingsPrivacy      = '/home/settings/privacy';
  static const String settingsDevices      = '/home/settings/devices';
  static const String settingsSessions     = '/home/settings/sessions';
  static const String settingsAbout        = '/home/settings/about';
  static const String settingsTerms        = '/home/settings/terms';

  // ── Support ────────────────────────────────────────────────────────────────
  static const String support        = '/home/support';
  static const String supportFaq     = '/home/support/faq';
  static const String supportChat    = '/home/support/chat';
  static const String supportTicket  = '/home/support/ticket';
  static const String supportTicketDetail = '/home/support/ticket/detail';
  static const String supportContact = '/home/support/contact';
  static const String supportCall    = '/home/support/call';
  static const String supportSuccess = '/home/support/success';

  // ── UI Showcase ────────────────────────────────────────────────────────────
  static const String showcase = '/showcase';
}