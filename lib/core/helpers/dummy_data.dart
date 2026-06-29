// =============================================================================
// dummy_data.dart — Données fictives FinTemp
// =============================================================================
// Emplacement : core/helpers/dummy_data.dart
//
// Fournit des données réalistes pour tous les écrans du template.
// Aucune logique métier réelle — uniquement des données statiques.
//
// UTILISATION :
//   DummyData.transactions  → liste de transactions
//   DummyData.cards         → liste de cartes bancaires
//   DummyData.user          → profil utilisateur
// =============================================================================

import '../enums/app_enums.dart';

// ── User ──────────────────────────────────────────────────────────────────────

class DummyUser {
  const DummyUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.iban,
    required this.kycStatus,
  });

  final String    id;
  final String    firstName;
  final String    lastName;
  final String    email;
  final String    phone;
  final String    avatarUrl;
  final String    iban;
  final KycStatus kycStatus;

  String get fullName => '$firstName $lastName';
  String get initials => '${firstName[0]}${lastName[0]}';
}

// ── Transaction ───────────────────────────────────────────────────────────────

class DummyTransaction {
  const DummyTransaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.status,
    required this.category,
    this.iconAsset,
  });

  final String            id;
  final String            title;
  final String            subtitle;
  final double            amount;
  final DateTime          date;
  final TransactionType   type;
  final TransactionStatus status;
  final String            category;
  final String?           iconAsset;

  bool get isIncome => type == TransactionType.income;
}

// ── Bank Card ─────────────────────────────────────────────────────────────────

class DummyCard {
  const DummyCard({
    required this.id,
    required this.lastFourDigits,
    required this.holderName,
    required this.expiryDate,
    required this.type,
    required this.network,
    required this.status,
    required this.balance,
    this.isDefault = false,
  });

  final String      id;
  final String      lastFourDigits;
  final String      holderName;
  final String      expiryDate;
  final CardType    type;
  final CardNetwork network;
  final CardStatus  status;
  final double      balance;
  final bool        isDefault;

  String get maskedNumber => '**** **** **** $lastFourDigits';
}

// ── Beneficiary ───────────────────────────────────────────────────────────────

class DummyBeneficiary {
  const DummyBeneficiary({
    required this.id,
    required this.name,
    required this.phone,
    required this.bank,
    this.avatarUrl,
    this.isFavorite = false,
  });

  final String  id;
  final String  name;
  final String  phone;
  final String  bank;
  final String? avatarUrl;
  final bool    isFavorite;

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return name[0];
  }
}

// ── Notification ──────────────────────────────────────────────────────────────

class DummyNotification {
  const DummyNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.type,
    this.isRead = false,
  });

  final String           id;
  final String           title;
  final String           body;
  final DateTime         date;
  final NotificationType type;
  final bool             isRead;
}

// =============================================================================
// DONNÉES FICTIVES STATIQUES
// =============================================================================

abstract final class DummyData {

  // ── Utilisateur ─────────────────────────────────────────────────────────────

  static const DummyUser user = DummyUser(
    id:         'usr_001',
    firstName:  'Kofi',
    lastName:   'Mensah',
    email:      'kofi.mensah@fintemp.app',
    phone:      '+229 97 12 34 56',
    avatarUrl:  'assets/avatars/avatar_01.png',
    iban:       'BJ00 0001 2345 6789 0123 4567',
    kycStatus:  KycStatus.verified,
  );

  // ── Solde ───────────────────────────────────────────────────────────────────

  static const double walletBalance    = 847200;
  static const double savingsBalance   = 320000;
  static const double investBalance    = 128400;
  static const String currency         = 'FCFA';

  // ── Cartes bancaires ────────────────────────────────────────────────────────

  static final List<DummyCard> cards = [
    const DummyCard(
      id:             'card_001',
      lastFourDigits: '4582',
      holderName:     'KOFI MENSAH',
      expiryDate:     '12/27',
      type:           CardType.physical,
      network:        CardNetwork.visa,
      status:         CardStatus.active,
      balance:        847200,
      isDefault:      true,
    ),
    const DummyCard(
      id:             'card_002',
      lastFourDigits: '7731',
      holderName:     'KOFI MENSAH',
      expiryDate:     '08/26',
      type:           CardType.virtual,
      network:        CardNetwork.mastercard,
      status:         CardStatus.active,
      balance:        250000,
    ),
    const DummyCard(
      id:             'card_003',
      lastFourDigits: '1190',
      holderName:     'KOFI MENSAH',
      expiryDate:     '03/25',
      type:           CardType.virtual,
      network:        CardNetwork.visa,
      status:         CardStatus.blocked,
      balance:        0,
    ),
  ];

  // ── Transactions ─────────────────────────────────────────────────────────

  static final List<DummyTransaction> transactions = [
    DummyTransaction(
      id:       'txn_001',
      title:    'Salaire Novembre',
      subtitle: 'Virement entrant',
      amount:   450000,
      date:     DateTime(2024, 11, 30, 9, 0),
      type:     TransactionType.income,
      status:   TransactionStatus.completed,
      category: 'Salaire',
    ),
    DummyTransaction(
      id:       'txn_002',
      title:    'Supermarché Erevan',
      subtitle: 'Paiement carte',
      amount:   -38500,
      date:     DateTime(2024, 11, 29, 15, 42),
      type:     TransactionType.expense,
      status:   TransactionStatus.completed,
      category: 'Alimentation',
    ),
    DummyTransaction(
      id:       'txn_003',
      title:    'Transfert à Ama Koffi',
      subtitle: 'Transfert interne',
      amount:   -75000,
      date:     DateTime(2024, 11, 28, 11, 15),
      type:     TransactionType.transfer,
      status:   TransactionStatus.completed,
      category: 'Transfert',
    ),
    DummyTransaction(
      id:       'txn_004',
      title:    'Facture d\'eau SONEB',
      subtitle: 'Paiement facture',
      amount:   -12800,
      date:     DateTime(2024, 11, 27, 8, 30),
      type:     TransactionType.expense,
      status:   TransactionStatus.completed,
      category: 'Factures',
    ),
    DummyTransaction(
      id:       'txn_005',
      title:    'Recharge Orange Money',
      subtitle: 'Mobile Money',
      amount:   -50000,
      date:     DateTime(2024, 11, 26, 18, 5),
      type:     TransactionType.expense,
      status:   TransactionStatus.completed,
      category: 'Mobile Money',
    ),
    DummyTransaction(
      id:       'txn_006',
      title:    'Remboursement Kévin',
      subtitle: 'Virement reçu',
      amount:   25000,
      date:     DateTime(2024, 11, 25, 14, 22),
      type:     TransactionType.income,
      status:   TransactionStatus.completed,
      category: 'Remboursement',
    ),
    DummyTransaction(
      id:       'txn_007',
      title:    'Netflix',
      subtitle: 'Abonnement mensuel',
      amount:   -8500,
      date:     DateTime(2024, 11, 24, 0, 0),
      type:     TransactionType.expense,
      status:   TransactionStatus.completed,
      category: 'Loisirs',
    ),
    DummyTransaction(
      id:       'txn_008',
      title:    'Loyer Décembre',
      subtitle: 'Virement programmé',
      amount:   -180000,
      date:     DateTime(2024, 11, 23, 9, 0),
      type:     TransactionType.expense,
      status:   TransactionStatus.pending,
      category: 'Logement',
    ),
    DummyTransaction(
      id:       'txn_009',
      title:    'Dividendes BRVM',
      subtitle: 'Investissement',
      amount:   32400,
      date:     DateTime(2024, 11, 22, 10, 0),
      type:     TransactionType.income,
      status:   TransactionStatus.completed,
      category: 'Investissement',
    ),
    DummyTransaction(
      id:       'txn_010',
      title:    'Pharmacie Centrale',
      subtitle: 'Paiement carte',
      amount:   -15200,
      date:     DateTime(2024, 11, 21, 16, 30),
      type:     TransactionType.expense,
      status:   TransactionStatus.completed,
      category: 'Santé',
    ),
  ];

  // ── Bénéficiaires ───────────────────────────────────────────────────────────

  static const List<DummyBeneficiary> beneficiaries = [
    DummyBeneficiary(
      id:          'ben_001',
      name:        'Ama Koffi',
      phone:       '+229 96 45 67 89',
      bank:        'FinTemp',
      isFavorite:  true,
    ),
    DummyBeneficiary(
      id:          'ben_002',
      name:        'Yao Djossou',
      phone:       '+229 97 23 45 67',
      bank:        'UBA Bénin',
      isFavorite:  true,
    ),
    DummyBeneficiary(
      id:          'ben_003',
      name:        'Fatou Diallo',
      phone:       '+221 77 345 67 89',
      bank:        'Ecobank',
      isFavorite:  false,
    ),
    DummyBeneficiary(
      id:          'ben_004',
      name:        'Moussa Traoré',
      phone:       '+223 76 12 34 56',
      bank:        'BOA Mali',
      isFavorite:  false,
    ),
    DummyBeneficiary(
      id:          'ben_005',
      name:        'Abena Asante',
      phone:       '+233 24 567 8901',
      bank:        'GCB Bank',
      isFavorite:  false,
    ),
  ];

  // ── Notifications ───────────────────────────────────────────────────────────

  static final List<DummyNotification> notifications = [
    DummyNotification(
      id:     'notif_001',
      title:  'Virement reçu',
      body:   'Vous avez reçu 450 000 FCFA de Salaire Novembre.',
      date:   DateTime(2024, 11, 30, 9, 2),
      type:   NotificationType.transaction,
      isRead: false,
    ),
    DummyNotification(
      id:     'notif_002',
      title:  'Paiement effectué',
      body:   'Paiement de 38 500 FCFA chez Supermarché Erevan.',
      date:   DateTime(2024, 11, 29, 15, 43),
      type:   NotificationType.transaction,
      isRead: false,
    ),
    DummyNotification(
      id:     'notif_003',
      title:  'Nouvelle connexion détectée',
      body:   'Une connexion depuis un nouvel appareil a été détectée.',
      date:   DateTime(2024, 11, 28, 20, 0),
      type:   NotificationType.security,
      isRead: true,
    ),
    DummyNotification(
      id:     'notif_004',
      title:  'Offre exclusive',
      body:   'Transférez maintenant et profitez de 0% de frais ce weekend !',
      date:   DateTime(2024, 11, 27, 10, 0),
      type:   NotificationType.promotion,
      isRead: true,
    ),
    DummyNotification(
      id:     'notif_005',
      title:  'Rappel de paiement',
      body:   'Votre loyer de 180 000 FCFA est programmé pour demain.',
      date:   DateTime(2024, 11, 22, 8, 0),
      type:   NotificationType.system,
      isRead: true,
    ),
  ];

  // ── Graphique mensuel (12 mois) ─────────────────────────────────────────────

  /// Dépenses par mois (FCFA).
  static const List<double> monthlyExpenses = [
    312000, 287000, 340000, 295000, 380000, 275000,
    320000, 355000, 290000, 410000, 365000, 328000,
  ];

  /// Revenus par mois (FCFA).
  static const List<double> monthlyIncome = [
    450000, 450000, 475000, 450000, 500000, 450000,
    450000, 475000, 450000, 475000, 450000, 500000,
  ];

  /// Labels des mois.
  static const List<String> monthLabels = [
    'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun',
    'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc',
  ];

  /// Dépenses par catégorie (pour graphique circulaire).
  static const Map<String, double> expensesByCategory = {
    'Logement':    180000,
    'Alimentation': 65000,
    'Transport':    35000,
    'Factures':     28000,
    'Loisirs':      22000,
    'Santé':        15200,
    'Autres':       20800,
  };
}
