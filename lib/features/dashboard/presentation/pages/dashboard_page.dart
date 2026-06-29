// =============================================================================
// dashboard_page.dart — Dashboard FinTemp (8 états/vues)
// =============================================================================
// Emplacement : features/dashboard/presentation/pages/dashboard_page.dart
//
// VUES COUVERTES (conforme au plan) :
//   1. Dashboard principal
//   2. Solde masqué
//   3. Solde affiché
//   4. Plusieurs comptes
//   5. Compte épargne (onglet)
//   6. Comptes devises (onglet)
//   7. Graphiques (section)
//   8. Widgets personnalisés (section)
//
// Toutes les vues sont accessibles depuis le même écran via :
//   - Toggle visibilité du solde
//   - Sélecteur de compte
//   - Section graphiques scrollable
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../core/design_system/badges/app_badge.dart';
import '../../../../core/helpers/dummy_data.dart';
import '../../../../core/widgets/wallet_card.dart';
import '../../../../core/widgets/transaction_tile.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  int _accountIndex = 0; // 0=principal, 1=épargne, 2=devises

  // Comptes fictifs
  final List<_AccountData> _accounts = [
    _AccountData(label: 'Compte principal', balance: DummyData.walletBalance,  currency: 'FCFA', icon: Icons.account_balance_wallet),
    _AccountData(label: 'Épargne',          balance: DummyData.savingsBalance,  currency: 'FCFA', icon: Icons.savings_outlined),
    _AccountData(label: 'EUR',              balance: 1250.0,                    currency: 'EUR',  icon: Icons.euro_outlined),
    _AccountData(label: 'USD',              balance: 850.0,                     currency: 'USD',  icon: Icons.attach_money_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final account  = _accounts[_accountIndex];

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── AppBar ───────────────────────────────────────────────
            SliverToBoxAdapter(child: _buildAppBar(isDark)),

            // ── Sélecteur de compte ──────────────────────────────────
            SliverToBoxAdapter(child: _buildAccountSelector(isDark)),

            // ── Wallet Card ──────────────────────────────────────────
            SliverPadding(
              padding: AppSpacing.screenPaddingH,
              sliver: SliverToBoxAdapter(
                child: WalletCard(
                  balance:   account.balance,
                  currency:  account.currency,
                  ownerName: DummyData.user.fullName,
                  onSend:    () => context.go(AppRoutes.transfers),
                  onReceive: () => context.go(AppRoutes.walletReceive),
                  onTopUp:   () => context.go(AppRoutes.walletTopUp),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.x2l)),

            // ── Actions rapides ──────────────────────────────────────
            SliverPadding(
              padding: AppSpacing.screenPaddingH,
              sliver: SliverToBoxAdapter(child: _buildQuickActions(isDark)),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.x2l)),

            // ── Graphique mensuel ────────────────────────────────────
            SliverPadding(
              padding: AppSpacing.screenPaddingH,
              sliver: SliverToBoxAdapter(child: _buildChart(isDark)),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.x2l)),

            // ── Cartes bancaires (aperçu) ────────────────────────────
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                isDark:  isDark,
                title:   'Mes cartes',
                onSeeAll: () => context.go(AppRoutes.cards),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 130,
                child: ListView.separated(
                  padding: AppSpacing.screenPaddingH,
                  scrollDirection: Axis.horizontal,
                  itemCount: DummyData.cards.length,
                  separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                  itemBuilder: (_, i) => _MiniCardTile(card: DummyData.cards[i]),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.x2l)),

            // ── Transactions récentes ────────────────────────────────
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                isDark:   isDark,
                title:    'Transactions récentes',
                onSeeAll: () => context.go(AppRoutes.history),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => TransactionTile.compact(
                  title:    DummyData.transactions[i].title,
                  subtitle: DummyData.transactions[i].subtitle,
                  amount:   DummyData.transactions[i].amount,
                  date:     DummyData.transactions[i].date,
                  type:     DummyData.transactions[i].type,
                  status:   DummyData.transactions[i].status,
                  category: DummyData.transactions[i].category,
                  onTap:    () => context.go(AppRoutes.historyDetail),
                ),
                childCount: DummyData.transactions.take(5).length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.x4l)),
          ],
        ),
      ),
    );
  }

  // ── AppBar ──────────────────────────────────────────────────────────────────

  Widget _buildAppBar(bool isDark) {
    final unread = DummyData.notifications.where((n) => !n.isRead).length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Avatar + salutation
          AppAvatar(initials: DummyData.user.initials, size: AppAvatarSize.md),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greeting(),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                  ),
                ),
                Text(
                  DummyData.user.firstName,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          // Notifications
          GestureDetector(
            onTap: () => context.go(AppRoutes.notifications),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color:        isDark ? AppColorsDark.inputBackground : AppColors.inputBackground,
                    borderRadius: AppRadius.mdRadius,
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                    size: 22,
                  ),
                ),
                if (unread > 0)
                  Positioned(
                    top: -4, right: -4,
                    child: NotificationBadge(count: unread),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Sélecteur de compte ─────────────────────────────────────────────────────

  Widget _buildAccountSelector(bool isDark) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: AppSpacing.screenPaddingH,
        scrollDirection: Axis.horizontal,
        itemCount: _accounts.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, i) {
          final isSelected = _accountIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _accountIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? AppColorsDark.primary : AppColors.primary)
                    : (isDark ? AppColorsDark.inputBackground : AppColors.inputBackground),
                borderRadius: AppRadius.fullRadius,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _accounts[i].icon,
                    size:  16,
                    color: isSelected
                        ? Colors.white
                        : (isDark ? AppColorsDark.textSecondary : AppColors.textSecondary),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    _accounts[i].label,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected
                          ? Colors.white
                          : (isDark ? AppColorsDark.textSecondary : AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Actions rapides ─────────────────────────────────────────────────────────

  Widget _buildQuickActions(bool isDark) {
    final actions = [
      (Icons.send_rounded,               'Envoyer',   AppRoutes.transfers),
      (Icons.qr_code_scanner_rounded,    'Scanner',   AppRoutes.paymentScanQr),
      (Icons.receipt_long_outlined,      'Payer',     AppRoutes.payments),
      (Icons.more_horiz_rounded,         'Plus',      AppRoutes.dashboard),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((a) {
        return GestureDetector(
          onTap: () => context.go(a.$3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  color:        isDark ? AppColorsDark.inputBackground : AppColors.inputBackground,
                  borderRadius: AppRadius.mdRadius,
                ),
                child: Icon(a.$1,
                  color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(a.$2, style: AppTextStyles.labelSmall.copyWith(
                color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
              )),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ── Graphique simplifié ─────────────────────────────────────────────────────

  Widget _buildChart(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color:        isDark ? AppColorsDark.surface : AppColors.surface,
        borderRadius: AppRadius.lgRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dépenses ce mois',
                style: AppTextStyles.titleSmall.copyWith(
                  color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                )),
              Text('Nov 2024',
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                )),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text('366 500 FCFA',
            style: AppTextStyles.headlineSmall.copyWith(
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
            )),
          const SizedBox(height: AppSpacing.lg),
          // Mini chart à barres
          MiniBarChart(
            data:   DummyData.monthlyExpenses,
            labels: DummyData.monthLabels,
            currentIndex: 10, // Novembre
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  // ── Section header ──────────────────────────────────────────────────────────

  Widget _buildSectionHeader({
    required bool isDark,
    required String title,
    required VoidCallback onSeeAll,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.titleMedium.copyWith(
            color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
          )),
          GestureDetector(
            onTap: onSeeAll,
            child: Text('Tout voir',
              style: AppTextStyles.labelMedium.copyWith(
                color: isDark ? AppColorsDark.primary : AppColors.primary,
              )),
          ),
        ],
      ),
    );
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Bonjour 👋';
    if (h < 18) return 'Bon après-midi 👋';
    return 'Bonsoir 👋';
  }
}

// ── Modèle compte ─────────────────────────────────────────────────────────────

class _AccountData {
  const _AccountData({
    required this.label,
    required this.balance,
    required this.currency,
    required this.icon,
  });
  final String   label;
  final double   balance;
  final String   currency;
  final IconData icon;
}

// ── Mini carte bancaire ───────────────────────────────────────────────────────

class _MiniCardTile extends StatelessWidget {
  const _MiniCardTile({required this.card});
  final DummyCard card;

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final isBlocked = card.status.name == 'blocked';

    return Container(
      width:  200,
      height: 120,
      decoration: BoxDecoration(
        gradient: isBlocked
            ? const LinearGradient(colors: [Color(0xFF8E8E93), Color(0xFF636366)])
            : AppColors.cardGradient,
        borderRadius: AppRadius.lgRadius,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(card.isDefault ? 'Principal' : card.type.name == 'virtual' ? 'Virtuelle' : 'Physique',
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.white.withAlpha(179),
                )),
              if (isBlocked)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color:        Colors.white.withAlpha(51),
                    borderRadius: AppRadius.fullRadius,
                  ),
                  child: Text('Bloquée', style: AppTextStyles.labelSmall.copyWith(
                    color: Colors.white, fontSize: 9,
                  )),
                ),
            ],
          ),
          const Spacer(),
          Text('**** ${card.lastFourDigits}',
            style: AppTextStyles.labelMedium.copyWith(
              color: Colors.white, letterSpacing: 2,
            )),
          const SizedBox(height: 4),
          Text(card.expiryDate,
            style: AppTextStyles.labelSmall.copyWith(
              color: Colors.white.withAlpha(153),
            )),
        ],
      ),
    );
  }
}
