// =============================================================================
// language_select_page.dart — Choix de la Langue FinTemp
// =============================================================================
// Emplacement : features/onboarding/presentation/pages/launch/language_select_page.dart
//
// Permet à l'utilisateur de choisir sa langue d'interface.
// Template : données fictives — 8 langues africaines + mondiales.
//
// COMPORTEMENT :
//   - Liste scrollable de langues avec drapeau + nom natif
//   - Sélection surlignée
//   - Bouton "Continuer" actif dès qu'une langue est sélectionnée
//   - Navigation vers CountrySelectPage
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../app/theme/app_radius.dart';
import '../../../../../core/design_system/buttons/app_button.dart';

// ── Modèle ────────────────────────────────────────────────────────────────────

class _Language {
  const _Language({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
  });
  final String code;
  final String name;
  final String nativeName;
  final String flag;
}

// ── Données fictives ──────────────────────────────────────────────────────────

const List<_Language> _languages = [
  _Language(code: 'fr', name: 'Français',   nativeName: 'Français',   flag: '🇫🇷'),
  _Language(code: 'en', name: 'English',    nativeName: 'English',    flag: '🇬🇧'),
  _Language(code: 'wo', name: 'Wolof',      nativeName: 'Wolof',      flag: '🇸🇳'),
  _Language(code: 'ha', name: 'Hausa',      nativeName: 'Harshen Hausa', flag: '🇳🇬'),
  _Language(code: 'sw', name: 'Swahili',    nativeName: 'Kiswahili',  flag: '🇰🇪'),
  _Language(code: 'am', name: 'Amharique',  nativeName: 'አማርኛ',        flag: '🇪🇹'),
  _Language(code: 'ar', name: 'Arabe',      nativeName: 'العربية',      flag: '🇲🇦'),
  _Language(code: 'pt', name: 'Portugais',  nativeName: 'Português',  flag: '🇧🇷'),
];

// =============================================================================
// LanguageSelectPage
// =============================================================================

class LanguageSelectPage extends StatefulWidget {
  const LanguageSelectPage({super.key});

  @override
  State<LanguageSelectPage> createState() => _LanguageSelectPageState();
}

class _LanguageSelectPageState extends State<LanguageSelectPage> {
  String _selected = 'fr'; // Français sélectionné par défaut

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── En-tête ────────────────────────────────────────────────
            Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Container(
                    width:  44,
                    height: 44,
                    decoration: BoxDecoration(
                      color:        isDark
                          ? AppColorsDark.primarySurface
                          : AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'FT',
                        style: AppTextStyles.titleSmall.copyWith(
                          color:      isDark ? AppColorsDark.primary : AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.x2l),

                  Text(
                    'Choisissez\nvotre langue',
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  Text(
                    'Sélectionnez la langue dans laquelle vous souhaitez utiliser FinTemp.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Liste des langues ──────────────────────────────────────
            Expanded(
              child: ListView.separated(
                padding: AppSpacing.screenPaddingH,
                itemCount: _languages.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                itemBuilder: (_, i) => _LanguageTile(
                  language:   _languages[i],
                  isSelected: _selected == _languages[i].code,
                  onTap: () => setState(() => _selected = _languages[i].code),
                ),
              ),
            ),

            // ── Bouton Continuer ───────────────────────────────────────
            Padding(
              padding: AppSpacing.screenPadding,
              child: AppButton.primary(
                label:     'Continuer',
                icon:      Icons.arrow_forward_rounded,
                onPressed: () => context.go(AppRoutes.countrySelect),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Tuile langue ──────────────────────────────────────────────────────────────

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final _Language language;
  final bool      isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isSelected
        ? (isDark ? AppColorsDark.primarySurface : AppColors.primarySurface)
        : (isDark ? AppColorsDark.surface : AppColors.surface);

    final borderColor = isSelected
        ? (isDark ? AppColorsDark.primary : AppColors.primary)
        : (isDark ? AppColorsDark.border  : AppColors.border);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:  const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color:        bgColor,
          borderRadius: AppRadius.lgRadius,
          border:       Border.all(color: borderColor, width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            // Drapeau
            Text(language.flag, style: const TextStyle(fontSize: 28)),

            const SizedBox(width: AppSpacing.md),

            // Noms
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language.nativeName,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: isSelected
                          ? (isDark ? AppColorsDark.primary : AppColors.primary)
                          : (isDark ? AppColorsDark.textPrimary : AppColors.textPrimary),
                    ),
                  ),
                  if (language.name != language.nativeName)
                    Text(
                      language.name,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),

            // Check
            AnimatedOpacity(
              opacity:  isSelected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.check_circle_rounded,
                color: isDark ? AppColorsDark.primary : AppColors.primary,
                size:  22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
