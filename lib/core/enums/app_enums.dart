// =============================================================================
// app_enums.dart — Énumérations partagées FinTemp
// =============================================================================
// Emplacement : core/enums/app_enums.dart
// =============================================================================

/// Statut d'une transaction.
enum TransactionStatus { pending, completed, failed, cancelled }

/// Type de transaction.
enum TransactionType { income, expense, transfer }

/// Type de carte bancaire.
enum CardType { virtual, physical }

/// Réseau de carte bancaire.
enum CardNetwork { visa, mastercard, amex }

/// Statut d'une carte bancaire.
enum CardStatus { active, blocked, expired }

/// Statut de vérification KYC.
enum KycStatus { notStarted, pending, verified, rejected }

/// Type de document KYC.
enum DocumentType { passport, nationalId, driverLicense, residencePermit }

/// Statut d'un prêt.
enum LoanStatus { requested, approved, rejected, active, paid }

/// Type d'épargne.
enum SavingType { goal, automatic, fixed }

/// Statut d'une épargne.
enum SavingStatus { active, paused, completed }

/// Type de notification.
enum NotificationType { transaction, security, promotion, system }

/// Type de transfert.
enum TransferType { internal, contact, bank, international }

/// Type de paiement.
enum PaymentType { qr, merchant, bill, mobileMoney, card, international }

/// Fréquence de récurrence.
enum RecurrenceFrequency { daily, weekly, monthly, yearly }

/// Statut d'un ticket support.
enum TicketStatus { open, inProgress, resolved, closed }

/// Thème de l'application.
enum AppThemeMode { light, dark, system }

/// Devise supportée.
enum Currency {
  fcfa(code: 'XOF', symbol: 'FCFA'),
  eur(code: 'EUR',  symbol: '€'),
  usd(code: 'USD',  symbol: '\$'),
  gbp(code: 'GBP',  symbol: '£');

  const Currency({required this.code, required this.symbol});
  final String code;
  final String symbol;
}
