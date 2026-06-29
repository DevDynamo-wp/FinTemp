// =============================================================================
// app_router.dart — Router principal FinTemp
// =============================================================================
// Emplacement : app/router/app_router.dart  (conforme au plan)
//
// Navigation déclarative avec go_router.
// Les chemins sont importés depuis route_names.dart.
//
// STRUCTURE :
//   Splash → Onboarding → Auth → KYC → Home (ShellRoute)
//   Le ShellRoute gère le bottom nav (Dashboard, Wallet, Cards,
//   Transfers, Profile).
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';

// ---------------------------------------------------------------------------
// PROVIDERS
// ---------------------------------------------------------------------------

/// Provider exposant le GoRouter à toute l'application.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: _routes,
    errorBuilder: (context, state) => const _NotFoundPage(),
  );
});

/// Provider gérant le thème actif (light / dark / system).
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

// ---------------------------------------------------------------------------
// ROUTES
// ---------------------------------------------------------------------------

final List<RouteBase> _routes = [
  // ── Lancement ─────────────────────────────────────────────────────────────
  GoRoute(
    path: AppRoutes.splash,
    name: 'splash',
    builder: (context, state) => const _Placeholder(title: 'Splash'),
  ),
  GoRoute(
    path: AppRoutes.languageSelect,
    name: 'language-select',
    builder: (context, state) => const _Placeholder(title: 'Choix de la langue'),
  ),
  GoRoute(
    path: AppRoutes.countrySelect,
    name: 'country-select',
    builder: (context, state) => const _Placeholder(title: 'Choix du pays'),
  ),
  GoRoute(
    path: AppRoutes.welcome,
    name: 'welcome',
    builder: (context, state) => const _Placeholder(title: 'Bienvenue'),
  ),

  // ── Onboarding ────────────────────────────────────────────────────────────
  GoRoute(
    path: AppRoutes.onboarding,
    name: 'onboarding',
    builder: (context, state) => const _Placeholder(title: 'Onboarding'),
  ),

  // ── Auth ──────────────────────────────────────────────────────────────────
  GoRoute(
    path: AppRoutes.login,
    name: 'login',
    builder: (context, state) => const _Placeholder(title: 'Login'),
    routes: [
      GoRoute(
        path: 'biometric',
        name: 'login-biometric',
        builder: (context, state) => const _Placeholder(title: 'Login Biométrie'),
      ),
      GoRoute(
        path: 'pin',
        name: 'login-pin',
        builder: (context, state) => const _Placeholder(title: 'Login PIN'),
      ),
      GoRoute(
        path: 'otp',
        name: 'login-otp',
        builder: (context, state) => const _Placeholder(title: 'Login OTP'),
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.sessionExpired,
    name: 'session-expired',
    builder: (context, state) => const _Placeholder(title: 'Session expirée'),
  ),
  GoRoute(
    path: AppRoutes.register,
    name: 'register',
    builder: (context, state) => const _Placeholder(title: 'Créer un compte'),
  ),
  GoRoute(
    path: AppRoutes.verifyEmail,
    name: 'verify-email',
    builder: (context, state) => const _Placeholder(title: 'Vérification Email'),
  ),
  GoRoute(
    path: AppRoutes.verifyPhone,
    name: 'verify-phone',
    builder: (context, state) => const _Placeholder(title: 'Vérification Téléphone'),
  ),
  GoRoute(
    path: AppRoutes.verifyOtp,
    name: 'verify-otp',
    builder: (context, state) => const _Placeholder(title: 'Vérification OTP'),
  ),
  GoRoute(
    path: AppRoutes.createPassword,
    name: 'create-password',
    builder: (context, state) => const _Placeholder(title: 'Créer mot de passe'),
  ),
  GoRoute(
    path: AppRoutes.confirmPassword,
    name: 'confirm-password',
    builder: (context, state) => const _Placeholder(title: 'Confirmer mot de passe'),
  ),
  GoRoute(
    path: AppRoutes.forgotPassword,
    name: 'forgot-password',
    builder: (context, state) => const _Placeholder(title: 'Mot de passe oublié'),
  ),
  GoRoute(
    path: AppRoutes.forgotOtp,
    name: 'forgot-otp',
    builder: (context, state) => const _Placeholder(title: 'OTP réinitialisation'),
  ),
  GoRoute(
    path: AppRoutes.resetPassword,
    name: 'reset-password',
    builder: (context, state) => const _Placeholder(title: 'Nouveau mot de passe'),
  ),
  GoRoute(
    path: AppRoutes.resetSuccess,
    name: 'reset-success',
    builder: (context, state) => const _Placeholder(title: 'Réinitialisation réussie'),
  ),
  GoRoute(
    path: AppRoutes.createPin,
    name: 'create-pin',
    builder: (context, state) => const _Placeholder(title: 'Créer PIN'),
  ),
  GoRoute(
    path: AppRoutes.confirmPin,
    name: 'confirm-pin',
    builder: (context, state) => const _Placeholder(title: 'Confirmer PIN'),
  ),
  GoRoute(
    path: AppRoutes.biometric,
    name: 'biometric-setup',
    builder: (context, state) => const _Placeholder(title: 'Face ID / Empreinte'),
  ),

  // ── KYC ───────────────────────────────────────────────────────────────────
  GoRoute(
    path: AppRoutes.kycIntro,
    name: 'kyc-intro',
    builder: (context, state) => const _Placeholder(title: 'Introduction KYC'),
    routes: [
      GoRoute(
        path: 'document',
        name: 'kyc-document',
        builder: (context, state) => const _Placeholder(title: 'Choix du document'),
      ),
      GoRoute(
        path: 'document/front',
        name: 'kyc-document-front',
        builder: (context, state) => const _Placeholder(title: 'Recto document'),
      ),
      GoRoute(
        path: 'document/back',
        name: 'kyc-document-back',
        builder: (context, state) => const _Placeholder(title: 'Verso document'),
      ),
      GoRoute(
        path: 'selfie',
        name: 'kyc-selfie',
        builder: (context, state) => const _Placeholder(title: 'Selfie'),
      ),
      GoRoute(
        path: 'pending',
        name: 'kyc-pending',
        builder: (context, state) => const _Placeholder(title: 'Vérification en cours'),
      ),
      GoRoute(
        path: 'success',
        name: 'kyc-success',
        builder: (context, state) => const _Placeholder(title: 'KYC réussie'),
      ),
      GoRoute(
        path: 'failed',
        name: 'kyc-failed',
        builder: (context, state) => const _Placeholder(title: 'KYC refusée'),
      ),
      GoRoute(
        path: 'resubmit',
        name: 'kyc-resubmit',
        builder: (context, state) => const _Placeholder(title: 'Nouvelle soumission'),
      ),
      GoRoute(
        path: 'proof-address',
        name: 'kyc-proof-address',
        builder: (context, state) => const _Placeholder(title: 'Justificatif domicile'),
      ),
      GoRoute(
        path: 'personal-info',
        name: 'kyc-personal-info',
        builder: (context, state) => const _Placeholder(title: 'Informations personnelles'),
      ),
      GoRoute(
        path: 'summary',
        name: 'kyc-summary',
        builder: (context, state) => const _Placeholder(title: 'Résumé KYC'),
      ),
    ],
  ),

  // ── Home Shell (Bottom Navigation) ────────────────────────────────────────
  ShellRoute(
    builder: (context, state, child) => _HomeShell(child: child),
    routes: [
      GoRoute(
        path: AppRoutes.dashboard,
        name: 'dashboard',
        builder: (context, state) => const _Placeholder(title: 'Dashboard'),
      ),
      GoRoute(
        path: AppRoutes.wallet,
        name: 'wallet',
        builder: (context, state) => const _Placeholder(title: 'Wallet'),
      ),
      GoRoute(
        path: AppRoutes.cards,
        name: 'cards',
        builder: (context, state) => const _Placeholder(title: 'Cartes'),
      ),
      GoRoute(
        path: AppRoutes.transfers,
        name: 'transfers',
        builder: (context, state) => const _Placeholder(title: 'Transferts'),
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (context, state) => const _Placeholder(title: 'Profil'),
      ),
    ],
  ),

  // ── Routes hors shell (plein écran) ───────────────────────────────────────
  GoRoute(
    path: AppRoutes.payments,
    name: 'payments',
    builder: (context, state) => const _Placeholder(title: 'Paiements'),
  ),
  GoRoute(
    path: AppRoutes.history,
    name: 'history',
    builder: (context, state) => const _Placeholder(title: 'Historique'),
  ),
  GoRoute(
    path: AppRoutes.notifications,
    name: 'notifications',
    builder: (context, state) => const _Placeholder(title: 'Notifications'),
  ),
  GoRoute(
    path: AppRoutes.statistics,
    name: 'statistics',
    builder: (context, state) => const _Placeholder(title: 'Statistiques'),
  ),
  GoRoute(
    path: AppRoutes.savings,
    name: 'savings',
    builder: (context, state) => const _Placeholder(title: 'Épargne'),
  ),
  GoRoute(
    path: AppRoutes.investments,
    name: 'investments',
    builder: (context, state) => const _Placeholder(title: 'Investissements'),
  ),
  GoRoute(
    path: AppRoutes.loans,
    name: 'loans',
    builder: (context, state) => const _Placeholder(title: 'Crédit / Prêt'),
  ),
  GoRoute(
    path: AppRoutes.settings,
    name: 'settings',
    builder: (context, state) => const _Placeholder(title: 'Paramètres'),
  ),
  GoRoute(
    path: AppRoutes.support,
    name: 'support',
    builder: (context, state) => const _Placeholder(title: 'Support'),
  ),

  // ── Showcase ──────────────────────────────────────────────────────────────
  GoRoute(
    path: AppRoutes.showcase,
    name: 'showcase',
    builder: (context, state) => const _Placeholder(title: 'UI Showcase'),
  ),
];

// ---------------------------------------------------------------------------
// HOME SHELL — Layout avec barre de navigation
// ---------------------------------------------------------------------------

/// Détermine l'index actif du NavigationBar selon la route courante.
int _locationToIndex(String location) {
  if (location.startsWith(AppRoutes.wallet))    return 1;
  if (location.startsWith(AppRoutes.cards))     return 2;
  if (location.startsWith(AppRoutes.transfers)) return 3;
  if (location.startsWith(AppRoutes.profile))   return 4;
  return 0; // dashboard par défaut
}

class _HomeShell extends StatelessWidget {
  const _HomeShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _locationToIndex(location),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card_outlined),
            selectedIcon: Icon(Icons.credit_card),
            label: 'Cartes',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_horiz_outlined),
            selectedIcon: Icon(Icons.swap_horiz),
            label: 'Transferts',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0: context.go(AppRoutes.dashboard);
            case 1: context.go(AppRoutes.wallet);
            case 2: context.go(AppRoutes.cards);
            case 3: context.go(AppRoutes.transfers);
            case 4: context.go(AppRoutes.profile);
          }
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// PLACEHOLDER — Page temporaire (sera remplacée feature par feature)
// ---------------------------------------------------------------------------

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 404
// ---------------------------------------------------------------------------

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64),
            const SizedBox(height: 16),
            Text('Page introuvable',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go(AppRoutes.splash),
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    );
  }
}
