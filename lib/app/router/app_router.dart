// =============================================================================
// app_router.dart — Router principal FinTemp (v4 — Auth complet)
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';

// ── Lancement ─────────────────────────────────────────────────────────────────
import '../../features/onboarding/presentation/pages/launch/splash_page.dart';
import '../../features/onboarding/presentation/pages/launch/splash_animated_page.dart';
import '../../features/onboarding/presentation/pages/launch/language_select_page.dart';
import '../../features/onboarding/presentation/pages/launch/country_select_page.dart';
import '../../features/onboarding/presentation/pages/launch/welcome_page.dart';

// ── Onboarding ────────────────────────────────────────────────────────────────
import '../../features/onboarding/presentation/pages/onboarding/onboarding_page.dart';

// ── Auth ──────────────────────────────────────────────────────────────────────
import '../../features/auth/presentation/pages/login/login_page.dart';
import '../../features/auth/presentation/pages/login/login_pin_page.dart';
import '../../features/auth/presentation/pages/login/login_biometric_page.dart';
import '../../features/auth/presentation/pages/login/session_expired_page.dart';
import '../../features/auth/presentation/pages/register/register_page.dart';
import '../../features/auth/presentation/pages/register/password_pages.dart';
import '../../features/auth/presentation/pages/verify_otp/verify_otp_page.dart';
import '../../features/auth/presentation/pages/pin/pin_pages.dart';
import '../../features/auth/presentation/pages/biometric/biometric_setup_page.dart';

final routerProvider = Provider<GoRouter>((ref) => GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: _routes,
  errorBuilder: (context, state) => const _NotFoundPage(),
));

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final List<RouteBase> _routes = [
  // ── Lancement ──────────────────────────────────────────────────────────────
  GoRoute(path: AppRoutes.splash,         name: 'splash',          builder: (_, __) => const SplashPage()),
  GoRoute(path: AppRoutes.splashAnimated, name: 'splash-animated', builder: (_, __) => const SplashAnimatedPage()),
  GoRoute(path: AppRoutes.languageSelect, name: 'language-select', builder: (_, __) => const LanguageSelectPage()),
  GoRoute(path: AppRoutes.countrySelect,  name: 'country-select',  builder: (_, __) => const CountrySelectPage()),
  GoRoute(path: AppRoutes.welcome,        name: 'welcome',         builder: (_, __) => const WelcomePage()),

  // ── Onboarding ─────────────────────────────────────────────────────────────
  GoRoute(path: AppRoutes.onboarding, name: 'onboarding', builder: (_, __) => const OnboardingPage()),

  // ── Auth — Connexion ───────────────────────────────────────────────────────
  GoRoute(path: AppRoutes.login,          name: 'login',           builder: (_, __) => const LoginPage()),
  GoRoute(path: AppRoutes.loginPin,       name: 'login-pin',       builder: (_, __) => const LoginPinPage()),
  GoRoute(path: AppRoutes.loginBiometric, name: 'login-biometric', builder: (_, __) => const LoginBiometricPage()),
  GoRoute(path: AppRoutes.sessionExpired, name: 'session-expired', builder: (_, __) => const SessionExpiredPage()),

  // ── Auth — Inscription ─────────────────────────────────────────────────────
  GoRoute(path: AppRoutes.register,        name: 'register',         builder: (_, __) => const RegisterPage()),
  GoRoute(path: AppRoutes.verifyEmail,     name: 'verify-email',     builder: (_, __) => const VerifyOtpPage(target: 'email', value: 'ko***@gmail.com', nextRoute: '/auth/password/create')),
  GoRoute(path: AppRoutes.verifyPhone,     name: 'verify-phone',     builder: (_, __) => const VerifyOtpPage(target: 'phone', value: '+229 97 *** **56', nextRoute: '/auth/password/create')),
  GoRoute(path: AppRoutes.verifyOtp,       name: 'verify-otp',       builder: (_, __) => const VerifyOtpPage()),
  GoRoute(path: AppRoutes.createPassword,  name: 'create-password',  builder: (_, __) => const CreatePasswordPage()),
  GoRoute(path: AppRoutes.confirmPassword, name: 'confirm-password', builder: (_, __) => const CreatePasswordPage()),

  // ── Auth — Mot de passe oublié ─────────────────────────────────────────────
  GoRoute(path: AppRoutes.forgotPassword, name: 'forgot-password', builder: (_, __) => const ForgotPasswordPage()),
  GoRoute(path: AppRoutes.forgotOtp,      name: 'forgot-otp',      builder: (_, __) => const VerifyOtpPage(target: 'email', value: 'ko***@gmail.com', nextRoute: '/auth/password/reset')),
  GoRoute(path: AppRoutes.resetPassword,  name: 'reset-password',  builder: (_, __) => const ResetPasswordPage()),
  GoRoute(path: AppRoutes.resetSuccess,   name: 'reset-success',   builder: (_, __) => const ResetSuccessPage()),

  // ── Auth — PIN & Biométrie ─────────────────────────────────────────────────
  GoRoute(path: AppRoutes.createPin,  name: 'create-pin',      builder: (_, __) => const CreatePinPage()),
  GoRoute(path: AppRoutes.confirmPin, name: 'confirm-pin',     builder: (_, state) => ConfirmPinPage(originalPin: (state.extra as String?) ?? '')),
  GoRoute(path: AppRoutes.biometric,  name: 'biometric-setup', builder: (_, __) => const BiometricSetupPage()),

  // ── KYC (placeholder) ──────────────────────────────────────────────────────
  GoRoute(path: AppRoutes.kycIntro, name: 'kyc-intro', builder: (_, __) => const _Placeholder(title: 'KYC')),

  // ── Home Shell ─────────────────────────────────────────────────────────────
  ShellRoute(
    builder: (context, state, child) => _HomeShell(child: child),
    routes: [
      GoRoute(path: AppRoutes.dashboard, name: 'dashboard', builder: (_, __) => const _Placeholder(title: 'Dashboard')),
      GoRoute(path: AppRoutes.wallet,    name: 'wallet',    builder: (_, __) => const _Placeholder(title: 'Wallet')),
      GoRoute(path: AppRoutes.cards,     name: 'cards',     builder: (_, __) => const _Placeholder(title: 'Cartes')),
      GoRoute(path: AppRoutes.transfers, name: 'transfers', builder: (_, __) => const _Placeholder(title: 'Transferts')),
      GoRoute(path: AppRoutes.profile,   name: 'profile',   builder: (_, __) => const _Placeholder(title: 'Profil')),
    ],
  ),

  // ── Autres (placeholders) ──────────────────────────────────────────────────
  GoRoute(path: AppRoutes.payments,      name: 'payments',      builder: (_, __) => const _Placeholder(title: 'Paiements')),
  GoRoute(path: AppRoutes.history,       name: 'history',       builder: (_, __) => const _Placeholder(title: 'Historique')),
  GoRoute(path: AppRoutes.notifications, name: 'notifications', builder: (_, __) => const _Placeholder(title: 'Notifications')),
  GoRoute(path: AppRoutes.statistics,    name: 'statistics',    builder: (_, __) => const _Placeholder(title: 'Statistiques')),
  GoRoute(path: AppRoutes.savings,       name: 'savings',       builder: (_, __) => const _Placeholder(title: 'Épargne')),
  GoRoute(path: AppRoutes.investments,   name: 'investments',   builder: (_, __) => const _Placeholder(title: 'Investissements')),
  GoRoute(path: AppRoutes.loans,         name: 'loans',         builder: (_, __) => const _Placeholder(title: 'Crédit')),
  GoRoute(path: AppRoutes.settings,      name: 'settings',      builder: (_, __) => const _Placeholder(title: 'Paramètres')),
  GoRoute(path: AppRoutes.support,       name: 'support',       builder: (_, __) => const _Placeholder(title: 'Support')),
  GoRoute(path: AppRoutes.showcase,      name: 'showcase',      builder: (_, __) => const _Placeholder(title: 'UI Showcase')),
];

int _locationToIndex(String loc) {
  if (loc.startsWith(AppRoutes.wallet))    return 1;
  if (loc.startsWith(AppRoutes.cards))     return 2;
  if (loc.startsWith(AppRoutes.transfers)) return 3;
  if (loc.startsWith(AppRoutes.profile))   return 4;
  return 0;
}

class _HomeShell extends StatelessWidget {
  const _HomeShell({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _locationToIndex(loc),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined),                    selectedIcon: Icon(Icons.home),                    label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined),  selectedIcon: Icon(Icons.account_balance_wallet),  label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.credit_card_outlined),             selectedIcon: Icon(Icons.credit_card),             label: 'Cartes'),
          NavigationDestination(icon: Icon(Icons.swap_horiz_outlined),              selectedIcon: Icon(Icons.swap_horiz),              label: 'Transferts'),
          NavigationDestination(icon: Icon(Icons.person_outline),                   selectedIcon: Icon(Icons.person),                  label: 'Profil'),
        ],
        onDestinationSelected: (i) {
          switch (i) {
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

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text(title, style: Theme.of(context).textTheme.headlineMedium)),
  );
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.error_outline, size: 64),
      const SizedBox(height: 16),
      Text('Page introuvable', style: Theme.of(context).textTheme.headlineSmall),
      TextButton(onPressed: () => context.go(AppRoutes.splash), child: const Text('Retour')),
    ])),
  );
}
