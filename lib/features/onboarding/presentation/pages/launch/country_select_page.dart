// =============================================================================
// country_select_page.dart — Choix du Pays FinTemp
// =============================================================================
// Emplacement : features/onboarding/presentation/pages/launch/country_select_page.dart
//
// Permet à l'utilisateur de sélectionner son pays de résidence.
// Données fictives : 20 pays africains + quelques pays mondiaux.
//
// FONCTIONNALITÉS :
//   - Barre de recherche filtrante
//   - Section "Populaires" + liste complète
//   - Indicatif téléphonique affiché
//   - Navigation vers WelcomePage
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../app/theme/app_radius.dart';
import '../../../../../core/design_system/buttons/app_button.dart';
import '../../../../../core/design_system/inputs/app_text_field.dart';

// ── Modèle ────────────────────────────────────────────────────────────────────

class _Country {
  const _Country({
    required this.code,
    required this.name,
    required this.flag,
    required this.dialCode,
    this.isPopular = false,
  });
  final String code;
  final String name;
  final String flag;
  final String dialCode;
  final bool   isPopular;
}

// ── Données fictives ──────────────────────────────────────────────────────────

const List<_Country> _countries = [
  _Country(code: 'BJ', name: 'Bénin',             flag: '🇧🇯', dialCode: '+229', isPopular: true),
  _Country(code: 'SN', name: 'Sénégal',            flag: '🇸🇳', dialCode: '+221', isPopular: true),
  _Country(code: 'CI', name: 'Côte d\'Ivoire',     flag: '🇨🇮', dialCode: '+225', isPopular: true),
  _Country(code: 'CM', name: 'Cameroun',           flag: '🇨🇲', dialCode: '+237', isPopular: true),
  _Country(code: 'GH', name: 'Ghana',              flag: '🇬🇭', dialCode: '+233', isPopular: true),
  _Country(code: 'NG', name: 'Nigeria',            flag: '🇳🇬', dialCode: '+234', isPopular: true),
  _Country(code: 'ML', name: 'Mali',               flag: '🇲🇱', dialCode: '+223'),
  _Country(code: 'BF', name: 'Burkina Faso',       flag: '🇧🇫', dialCode: '+226'),
  _Country(code: 'TG', name: 'Togo',               flag: '🇹🇬', dialCode: '+228'),
  _Country(code: 'NE', name: 'Niger',              flag: '🇳🇪', dialCode: '+227'),
  _Country(code: 'GN', name: 'Guinée',             flag: '🇬🇳', dialCode: '+224'),
  _Country(code: 'CD', name: 'Congo (RDC)',         flag: '🇨🇩', dialCode: '+243'),
  _Country(code: 'CG', name: 'Congo (Brazzaville)', flag: '🇨🇬', dialCode: '+242'),
  _Country(code: 'GA', name: 'Gabon',              flag: '🇬🇦', dialCode: '+241'),
  _Country(code: 'MA', name: 'Maroc',              flag: '🇲🇦', dialCode: '+212'),
  _Country(code: 'TN', name: 'Tunisie',            flag: '🇹🇳', dialCode: '+216'),
  _Country(code: 'KE', name: 'Kenya',              flag: '🇰🇪', dialCode: '+254'),
  _Country(code: 'ET', name: 'Éthiopie',           flag: '🇪🇹', dialCode: '+251'),
  _Country(code: 'TZ', name: 'Tanzanie',           flag: '🇹🇿', dialCode: '+255'),
  _Country(code: 'FR', name: 'France',             flag: '🇫🇷', dialCode: '+33'),
  _Country(code: 'BE', name: 'Belgique',           flag: '🇧🇪', dialCode: '+32'),
  _Country(code: 'CA', name: 'Canada',             flag: '🇨🇦', dialCode: '+1'),
];

// =============================================================================
// CountrySelectPage
// =============================================================================

class CountrySelectPage extends StatefulWidget {
  const CountrySelectPage({super.key});

  @override
  State<CountrySelectPage> createState() => _CountrySelectPageState();
}

class _CountrySelectPageState extends State<CountrySelectPage> {
  String?                  _selected;
  String                   _query = '';
  final TextEditingController _searchCtrl = TextEditingController();

  List<_Country> get _filtered {
    if (_query.isEmpty) return _countries;
    final q = _query.toLowerCase();
    return _countries.where((c) =>
      c.name.toLowerCase().contains(q) ||
      c.dialCode.contains(q) ||
      c.code.toLowerCase().contains(q),
    ).toList();
  }

  List<_Country> get _popular =>
      _filtered.where((c) => c.isPopular).toList();

  List<_Country> get _others =>
      _filtered.where((c) => !c.isPopular).toList();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

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
              padding: AppSpacing.screenPadding.copyWith(bottom: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Retour
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width:  40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDark ? AppColorsDark.inputBackground : AppColors.inputBackground,
                        borderRadius: AppRadius.mdRadius,
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.x2l),

                  Text(
                    'Votre pays',
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Indiquez votre pays de résidence pour personnaliser votre expérience.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // ── Recherche ──────────────────────────────────────────────
            Padding(
              padding: AppSpacing.screenPaddingH,
              child: AppTextField.search(
                controller: _searchCtrl,
                hint:       'Rechercher un pays...',
                onChanged:  (v) => setState(() => _query = v),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // ── Liste ──────────────────────────────────────────────────
            Expanded(
              child: _filtered.isEmpty
                  ? _buildEmpty(isDark)
                  : ListView(
                      padding: AppSpacing.screenPaddingH,
                      children: [
                        if (_popular.isNotEmpty && _query.isEmpty) ...[
                          _SectionLabel(label: 'Populaires', isDark: isDark),
                          const SizedBox(height: AppSpacing.sm),
                          ..._popular.map((c) => _CountryTile(
                            country:    c,
                            isSelected: _selected == c.code,
                            onTap: () => setState(() => _selected = c.code),
                          )),
                          const SizedBox(height: AppSpacing.lg),
                          _SectionLabel(label: 'Tous les pays', isDark: isDark),
                          const SizedBox(height: AppSpacing.sm),
                        ],
                        ..._others.map((c) => _CountryTile(
                          country:    c,
                          isSelected: _selected == c.code,
                          onTap: () => setState(() => _selected = c.code),
                        )),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                    ),
            ),

            // ── Bouton ─────────────────────────────────────────────────
            Padding(
              padding: AppSpacing.screenPadding,
              child: AppButton.primary(
                label:     'Continuer',
                icon:      Icons.arrow_forward_rounded,
                onPressed: _selected != null
                    ? () => context.go(AppRoutes.welcome)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size:  56,
            color: isDark ? AppColorsDark.neutral400 : AppColors.neutral400,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Aucun pays trouvé',
            style: AppTextStyles.titleMedium.copyWith(
              color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Essayez un autre terme de recherche.',
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Composants internes ───────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.isDark});
  final String label;
  final bool   isDark;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: AppTextStyles.labelSmall.copyWith(
        color:         isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
        letterSpacing: 1.5,
      ),
    );
  }
}

class _CountryTile extends StatelessWidget {
  const _CountryTile({
    required this.country,
    required this.isSelected,
    required this.onTap,
  });

  final _Country country;
  final bool     isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin:   const EdgeInsets.only(bottom: AppSpacing.sm),
        padding:  const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical:   AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColorsDark.primarySurface : AppColors.primarySurface)
              : Colors.transparent,
          borderRadius: AppRadius.lgRadius,
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColorsDark.primary : AppColors.primary)
                : (isDark ? AppColorsDark.border  : AppColors.border),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(country.flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                country.name,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            Text(
              country.dialCode,
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: AppSpacing.sm),
              Icon(
                Icons.check_circle_rounded,
                color: isDark ? AppColorsDark.primary : AppColors.primary,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
