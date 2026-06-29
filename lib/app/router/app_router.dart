// =============================================================================
// app_router.dart — Router principal FinTemp (v5 — KYC + Dashboard)
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';

// Lancement
import '../../features/onboarding/presentation/pages/launch/splash_page.dart';
import '../../features/onboarding/presentation/pages/launch/splash_animated_page.dart';
import '../../features/onboarding/presentation/pages/launch/language_select_page.dart';
import '../../features/onboarding/presentation/pages/launch/country_select_page.dart';
import '../../features/onboarding/presentation/pages/launch/welcome_page.dart';
// Onboarding
import '../../features/onboarding/presentation/pages/onboarding/onboarding_page.dart';
// Auth
import '../../features/auth/presentation/pages/login/login_page.dart';
import '../../features/auth/presentation/pages/login/login_pin_page.dart';
import '../../features/auth/presentation/pages/login/login_biometric_page.dart';
import '../../features/auth/presentation/pages/login/session_expired_page.dart';
import '../../features/auth/presentation/pages/register/register_page.dart';
import '../../features/auth/presentation/pages/register/password_pages.dart';
import '../../features/auth/presentation/pages/verify_otp/verify_otp_page.dart';
import '../../features/auth/presentation/pages/pin/pin_pages.dart';
import '../../features/auth/presentation/pages/biometric/biometric_setup_page.dart';
// KYC
import '../../features/kyc/presentation/pages/kyc_pages.dart';
// Dashboard
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

final routerProvider = Provider<GoRouter>((ref) => GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: _routes,
  errorBuilder: (_, __) => const _NotFoundPage(),
));

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final List<RouteBase> _routes = [
  // Lancement
  GoRoute(path: AppRoutes.splash,         builder: (_, __) => const SplashPage()),
  GoRoute(path: AppRoutes.splashAnimated, builder: (_, __) => const SplashAnimatedPage()),
  GoRoute(path: AppRoutes.languageSelect, builder: (_, __) => const LanguageSelectPage()),
  GoRoute(path: AppRoutes.countrySelect,  builder: (_, __) => const CountrySelectPage()),
  GoRoute(path: AppRoutes.welcome,        builder: (_, __) => const WelcomePage()),
  // Onboarding
  GoRoute(path: AppRoutes.onboarding,     builder: (_, __) => const OnboardingPage()),
  // Auth
  GoRoute(path: AppRoutes.login,          builder: (_, __) => const LoginPage()),
  GoRoute(path: AppRoutes.loginPin,       builder: (_, __) => const LoginPinPage()),
  GoRoute(path: AppRoutes.loginBiometric, builder: (_, __) => const LoginBiometricPage()),
  GoRoute(path: AppRoutes.sessionExpired, builder: (_, __) => const SessionExpiredPage()),
  GoRoute(path: AppRoutes.register,       builder: (_, __) => const RegisterPage()),
  GoRoute(path: AppRoutes.verifyEmail,    builder: (_, __) => const VerifyOtpPage(target: 'email', value: 'ko***@gmail.com', nextRoute: '/auth/password/create')),
  GoRoute(path: AppRoutes.verifyPhone,    builder: (_, __) => const VerifyOtpPage(target: 'phone', value: '+229 97 *** **56', nextRoute: '/auth/password/create')),
  GoRoute(path: AppRoutes.verifyOtp,      builder: (_, __) => const VerifyOtpPage()),
  GoRoute(path: AppRoutes.createPassword, builder: (_, __) => const CreatePasswordPage()),
  GoRoute(path: AppRoutes.confirmPassword,builder: (_, __) => const CreatePasswordPage()),
  GoRoute(path: AppRoutes.forgotPassword, builder: (_, __) => const ForgotPasswordPage()),
  GoRoute(path: AppRoutes.forgotOtp,      builder: (_, __) => const VerifyOtpPage(target: 'email', value: 'ko***@gmail.com', nextRoute: '/auth/password/reset')),
  GoRoute(path: AppRoutes.resetPassword,  builder: (_, __) => const ResetPasswordPage()),
  GoRoute(path: AppRoutes.resetSuccess,   builder: (_, __) => const ResetSuccessPage()),
  GoRoute(path: AppRoutes.createPin,      builder: (_, __) => const CreatePinPage()),
  GoRoute(path: AppRoutes.confirmPin,     builder: (_, s)  => ConfirmPinPage(originalPin: (s.extra as String?) ?? '')),
  GoRoute(path: AppRoutes.biometric,      builder: (_, __) => const BiometricSetupPage()),
  // KYC
  GoRoute(path: AppRoutes.kycIntro,       builder: (_, __) => const KycIntroPage()),
  GoRoute(path: AppRoutes.kycPersonalInfo,builder: (_, __) => const KycPersonalInfoPage()),
  GoRoute(path: AppRoutes.kycDocument,    builder: (_, __) => const KycDocumentChoicePage()),
  GoRoute(path: AppRoutes.kycDocumentFront, builder: (_, __) => const KycDocumentCapturePage(isFront: true)),
  GoRoute(path: AppRoutes.kycDocumentBack,  builder: (_, __) => const KycDocumentCapturePage(isFront: false)),
  GoRoute(path: AppRoutes.kycSelfie,      builder: (_, __) => const KycSelfiePage()),
  GoRoute(path: AppRoutes.kycPending,     builder: (_, __) => const KycPendingPage()),
  GoRoute(path: AppRoutes.kycSuccess,     builder: (_, __) => const KycSuccessPage()),
  GoRoute(path: AppRoutes.kycFailed,      builder: (_, __) => const KycFailedPage()),
  GoRoute(path: AppRoutes.kycResubmit,    builder: (_, __) => const KycIntroPage()),
  GoRoute(path: AppRoutes.kycProofAddress,builder: (_, __) => const KycProofAddressPage()),
  GoRoute(path: AppRoutes.kycSummary,     builder: (_, __) => const KycSummaryPage()),
  // Home Shell
  ShellRoute(
    builder: (context, state, child) => _HomeShell(child: child),
    routes: [
      GoRoute(path: AppRoutes.dashboard, builder: (_, __) => const DashboardPage()),
      GoRoute(path: AppRoutes.wallet,    builder: (_, __) => const _Placeholder(title: 'Wallet')),
      GoRoute(path: AppRoutes.cards,     builder: (_, __) => const _Placeholder(title: 'Cartes')),
      GoRoute(path: AppRoutes.transfers, builder: (_, __) => const _Placeholder(title: 'Transferts')),
      GoRoute(path: AppRoutes.profile,   builder: (_, __) => const _Placeholder(title: 'Profil')),
    ],
  ),
  // Autres
  GoRoute(path: AppRoutes.payments,       builder: (_, __) => const _Placeholder(title: 'Paiements')),
  GoRoute(path: AppRoutes.paymentScanQr,  builder: (_, __) => const _Placeholder(title: 'Scanner QR')),
  GoRoute(path: AppRoutes.walletTopUp,    builder: (_, __) => const _Placeholder(title: 'Recharger')),
  GoRoute(path: AppRoutes.walletReceive,  builder: (_, __) => const _Placeholder(title: 'Recevoir')),
  GoRoute(path: AppRoutes.history,        builder: (_, __) => const _Placeholder(title: 'Historique')),
  GoRoute(path: AppRoutes.historyDetail,  builder: (_, __) => const _Placeholder(title: 'Détail transaction')),
  GoRoute(path: AppRoutes.notifications,  builder: (_, __) => const _Placeholder(title: 'Notifications')),
  GoRoute(path: AppRoutes.statistics,     builder: (_, __) => const _Placeholder(title: 'Statistiques')),
  GoRoute(path: AppRoutes.savings,        builder: (_, __) => const _Placeholder(title: 'Épargne')),
  GoRoute(path: AppRoutes.investments,    builder: (_, __) => const _Placeholder(title: 'Investissements')),
  GoRoute(path: AppRoutes.loans,          builder: (_, __) => const _Placeholder(title: 'Crédit')),
  GoRoute(path: AppRoutes.settings,       builder: (_, __) => const _Placeholder(title: 'Paramètres')),
  GoRoute(path: AppRoutes.support,        builder: (_, __) => const _Placeholder(title: 'Support')),
  GoRoute(path: AppRoutes.showcase,       builder: (_, __) => const _Placeholder(title: 'UI Showcase')),
];

int _idx(String loc) {
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
        selectedIndex: _idx(loc),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined),                   selectedIcon: Icon(Icons.home),                   label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), selectedIcon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.credit_card_outlined),            selectedIcon: Icon(Icons.credit_card),            label: 'Cartes'),
          NavigationDestination(icon: Icon(Icons.swap_horiz_outlined),             selectedIcon: Icon(Icons.swap_horiz),             label: 'Transferts'),
          NavigationDestination(icon: Icon(Icons.person_outline),                  selectedIcon: Icon(Icons.person),                 label: 'Profil'),
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
