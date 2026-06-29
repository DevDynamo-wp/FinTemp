// =============================================================================
// app.dart — Widget racine de FinTemp
// =============================================================================
// Emplacement : app/app.dart  (conforme au plan)
//
// Assemble : AppTheme + AppRouter + Localisation.
// Reste intentionnellement léger.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme/app_theme.dart';
import 'router/app_router.dart';

class FinTempApp extends ConsumerWidget {
  const FinTempApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final router    = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'FinTemp',
      debugShowCheckedModeBanner: false,
      theme:      AppTheme.light,
      darkTheme:  AppTheme.dark,
      themeMode:  themeMode,
      routerConfig: router,
      locale: const Locale('fr'),
      supportedLocales: const [Locale('fr'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
