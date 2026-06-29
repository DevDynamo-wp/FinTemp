// =============================================================================
// kyc_pages.dart — Vérification d'identité FinTemp (12 écrans)
// =============================================================================
// Emplacement : features/kyc/presentation/pages/kyc_pages.dart
//
// ÉCRANS :
//   KycIntroPage          → introduction + explication du processus
//   KycDocumentChoicePage → choix du type de document
//   KycDocumentCapturePage→ recto / verso (réutilisable)
//   KycSelfiePage         → capture selfie
//   KycPendingPage        → vérification en cours
//   KycSuccessPage        → vérification réussie
//   KycFailedPage         → vérification refusée
//   KycResubmitPage       → nouvelle soumission
//   KycProofAddressPage   → justificatif de domicile
//   KycPersonalInfoPage   → informations personnelles
//   KycSummaryPage        → résumé avant soumission
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../core/design_system/buttons/app_button.dart';
import '../../../../core/design_system/inputs/app_text_field.dart';

// ── Stepper partagé ───────────────────────────────────────────────────────────

class _KycStepper extends StatelessWidget {
  const _KycStepper({required this.currentStep, required this.totalSteps});
  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Étape $currentStep sur $totalSteps',
              style: AppTextStyles.labelMedium.copyWith(
                color: isDark ? AppColorsDark.primary : AppColors.primary,
              ),
            ),
            Text(
              '${((currentStep / totalSteps) * 100).round()}%',
              style: AppTextStyles.labelMedium.copyWith(
                color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: AppRadius.fullRadius,
          child: LinearProgressIndicator(
            value:           currentStep / totalSteps,
            minHeight:       6,
            backgroundColor: isDark ? AppColorsDark.neutral200 : AppColors.neutral200,
            valueColor:      AlwaysStoppedAnimation(
              isDark ? AppColorsDark.primary : AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Wrapper KYC ───────────────────────────────────────────────────────────────

class _KycPageWrapper extends StatelessWidget {
  const _KycPageWrapper({
    required this.child,
    required this.step,
    required this.totalSteps,
    this.title,
  });
  final Widget child;
  final int    step;
  final int    totalSteps;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: title != null ? Text(title!) : null,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).canPop()
              ? Navigator.of(context).pop()
              : context.go(AppRoutes.welcome),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _KycStepper(currentStep: step, totalSteps: totalSteps),
              const SizedBox(height: AppSpacing.x2l),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 1. KycIntroPage
// =============================================================================

class KycIntroPage extends StatelessWidget {
  const KycIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              // Icône
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(
                  color:        isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.verified_user_outlined,
                  color: isDark ? AppColorsDark.primary : AppColors.primary,
                  size: 36,
                ),
              ),

              const SizedBox(height: AppSpacing.x2l),

              Text('Vérifiez votre\nidentité',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                )),

              const SizedBox(height: AppSpacing.md),

              Text(
                'Pour sécuriser votre compte et respecter la réglementation, nous devons vérifier votre identité.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSpacing.x3l),

              // Étapes
              ...[
                (Icons.badge_outlined,    '1. Pièce d\'identité',    'Passeport, carte nationale ou permis de conduire'),
                (Icons.face_outlined,     '2. Selfie',               'Une photo de vous en temps réel'),
                (Icons.home_outlined,     '3. Justificatif',         'Facture ou relevé bancaire récent'),
              ].map((item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color:        isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
                        borderRadius: AppRadius.mdRadius,
                      ),
                      child: Icon(item.$1,
                        color: isDark ? AppColorsDark.primary : AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.$2,
                            style: AppTextStyles.titleSmall.copyWith(
                              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                            )),
                          Text(item.$3,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                            )),
                        ],
                      ),
                    ),
                  ],
                ),
              )),

              const Spacer(),

              AppButton.primary(
                label:     'Commencer la vérification',
                icon:      Icons.arrow_forward_rounded,
                onPressed: () => context.go(AppRoutes.kycPersonalInfo),
              ),

              const SizedBox(height: AppSpacing.md),

              AppButton.ghost(
                label:       'Le faire plus tard',
                onPressed:   () => context.go(AppRoutes.dashboard),
                isFullWidth: true,
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 2. KycPersonalInfoPage
// =============================================================================

class KycPersonalInfoPage extends StatefulWidget {
  const KycPersonalInfoPage({super.key});

  @override
  State<KycPersonalInfoPage> createState() => _KycPersonalInfoPageState();
}

class _KycPersonalInfoPageState extends State<KycPersonalInfoPage> {
  final _formKey     = GlobalKey<FormState>();
  final _dobCtrl     = TextEditingController(text: '01/01/1990');
  final _addressCtrl = TextEditingController(text: 'Rue des Cocotiers, Cotonou');
  final _cityCtrl    = TextEditingController(text: 'Cotonou');
  String _nationality = 'Béninoise';

  @override
  void dispose() {
    _dobCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _KycPageWrapper(
      step: 1, totalSteps: 4, title: 'Informations personnelles',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Confirmez vos informations',
              style: AppTextStyles.titleLarge.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColorsDark.textPrimary : AppColors.textPrimary,
              )),
            const SizedBox(height: AppSpacing.xs),
            Text('Ces informations doivent correspondre à votre pièce d\'identité.',
              style: AppTextStyles.bodySmall.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColorsDark.textSecondary : AppColors.textSecondary,
              )),
            const SizedBox(height: AppSpacing.x2l),

            AppTextField(
              controller: _dobCtrl,
              label:      'Date de naissance',
              prefixIcon: Icons.calendar_today_outlined,
              validator:  (v) => v == null || v.isEmpty ? 'Requis' : null,
            ),
            const SizedBox(height: AppSpacing.md),

            // Nationalité — dropdown simulé
            _NationalityPicker(
              value:    _nationality,
              onChanged: (v) => setState(() => _nationality = v),
            ),
            const SizedBox(height: AppSpacing.md),

            AppTextField(
              controller: _addressCtrl,
              label:      'Adresse',
              prefixIcon: Icons.location_on_outlined,
              validator:  (v) => v == null || v.isEmpty ? 'Requis' : null,
            ),
            const SizedBox(height: AppSpacing.md),

            AppTextField(
              controller: _cityCtrl,
              label:      'Ville',
              prefixIcon: Icons.location_city_outlined,
              validator:  (v) => v == null || v.isEmpty ? 'Requis' : null,
            ),
            const SizedBox(height: AppSpacing.x3l),

            AppButton.primary(
              label:     'Continuer',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.go(AppRoutes.kycDocument);
                }
              },
            ),
            const SizedBox(height: AppSpacing.x2l),
          ],
        ),
      ),
    );
  }
}

class _NationalityPicker extends StatelessWidget {
  const _NationalityPicker({required this.value, required this.onChanged});
  final String             value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () async {
        final options = ['Béninoise', 'Sénégalaise', 'Ivoirienne', 'Ghanéenne', 'Nigériane', 'Camerounaise'];
        final result = await showModalBottomSheet<String>(
          context: context,
          builder: (_) => ListView(
            shrinkWrap: true,
            padding: AppSpacing.screenPadding,
            children: [
              Text('Nationalité', style: AppTextStyles.titleLarge),
              const SizedBox(height: AppSpacing.lg),
              ...options.map((o) => ListTile(
                title: Text(o),
                trailing: o == value ? Icon(Icons.check, color: isDark ? AppColorsDark.primary : AppColors.primary) : null,
                onTap: () => Navigator.pop(context, o),
              )),
            ],
          ),
        );
        if (result != null) onChanged(result);
      },
      child: Container(
        height: AppSpacing.inputHeight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        decoration: BoxDecoration(
          color:        isDark ? AppColorsDark.inputBackground : AppColors.inputBackground,
          borderRadius: AppRadius.input,
        ),
        child: Row(
          children: [
            Icon(Icons.flag_outlined, size: 20, color: isDark ? AppColorsDark.neutral500 : AppColors.neutral500),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(value, style: AppTextStyles.bodyLarge.copyWith(
                color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              )),
            ),
            Icon(Icons.keyboard_arrow_down_rounded, color: isDark ? AppColorsDark.neutral500 : AppColors.neutral500),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 3. KycDocumentChoicePage
// =============================================================================

class KycDocumentChoicePage extends StatefulWidget {
  const KycDocumentChoicePage({super.key});

  @override
  State<KycDocumentChoicePage> createState() => _KycDocumentChoicePageState();
}

class _KycDocumentChoicePageState extends State<KycDocumentChoicePage> {
  String? _selected;

  final List<_DocType> _docs = const [
    _DocType(id: 'passport',    label: 'Passeport',              icon: Icons.book_outlined),
    _DocType(id: 'national_id', label: 'Carte nationale d\'identité', icon: Icons.credit_card_outlined),
    _DocType(id: 'driver',      label: 'Permis de conduire',      icon: Icons.drive_eta_outlined),
    _DocType(id: 'residence',   label: 'Titre de séjour',         icon: Icons.article_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return _KycPageWrapper(
      step: 2, totalSteps: 4, title: 'Pièce d\'identité',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choisissez votre document',
            style: AppTextStyles.titleLarge.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColorsDark.textPrimary : AppColors.textPrimary,
            )),
          const SizedBox(height: AppSpacing.xs),
          Text('Sélectionnez le type de document que vous souhaitez utiliser.',
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColorsDark.textSecondary : AppColors.textSecondary,
            )),
          const SizedBox(height: AppSpacing.x2l),

          ..._docs.map((doc) => _DocTypeTile(
            doc:        doc,
            isSelected: _selected == doc.id,
            onTap:      () => setState(() => _selected = doc.id),
          )),

          const SizedBox(height: AppSpacing.x3l),

          AppButton.primary(
            label:     'Continuer',
            onPressed: _selected != null
                ? () => context.go(AppRoutes.kycDocumentFront)
                : null,
          ),
          const SizedBox(height: AppSpacing.x2l),
        ],
      ),
    );
  }
}

class _DocType {
  const _DocType({required this.id, required this.label, required this.icon});
  final String   id;
  final String   label;
  final IconData icon;
}

class _DocTypeTile extends StatelessWidget {
  const _DocTypeTile({required this.doc, required this.isSelected, required this.onTap});
  final _DocType     doc;
  final bool         isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin:   const EdgeInsets.only(bottom: AppSpacing.md),
        padding:  const EdgeInsets.all(AppSpacing.lg),
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
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? AppColorsDark.primary : AppColors.primary)
                    : (isDark ? AppColorsDark.inputBackground : AppColors.inputBackground),
                borderRadius: AppRadius.mdRadius,
              ),
              child: Icon(doc.icon,
                color: isSelected ? Colors.white : (isDark ? AppColorsDark.neutral500 : AppColors.neutral500),
                size: 22,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(doc.label,
                style: AppTextStyles.titleSmall.copyWith(
                  color: isSelected
                      ? (isDark ? AppColorsDark.primary : AppColors.primary)
                      : (isDark ? AppColorsDark.textPrimary : AppColors.textPrimary),
                )),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded,
                color: isDark ? AppColorsDark.primary : AppColors.primary,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 4. KycDocumentCapturePage (recto et verso)
// =============================================================================

class KycDocumentCapturePage extends StatefulWidget {
  const KycDocumentCapturePage({this.isFront = true, super.key});
  final bool isFront;

  @override
  State<KycDocumentCapturePage> createState() => _KycDocumentCapturePageState();
}

class _KycDocumentCapturePageState extends State<KycDocumentCapturePage> {
  bool _captured = false;

  void _simulateCapture() {
    setState(() => _captured = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      if (widget.isFront) {
        context.go(AppRoutes.kycDocumentBack);
      } else {
        context.go(AppRoutes.kycSelfie);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final label   = widget.isFront ? 'Recto' : 'Verso';
    final step    = widget.isFront ? 3 : 4;

    return _KycPageWrapper(
      step: step, totalSteps: 6,
      title: 'Document — $label',
      child: Column(
        children: [
          Text('Photographiez le $label',
            style: AppTextStyles.titleLarge.copyWith(
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
            )),
          const SizedBox(height: AppSpacing.xs),
          Text('Assurez-vous que le document est bien visible et lisible.',
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
            )),
          const SizedBox(height: AppSpacing.x3l),

          // Zone de capture simulée
          GestureDetector(
            onTap: _simulateCapture,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width:  double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: _captured
                    ? (isDark ? AppColorsDark.successLight : AppColors.successLight)
                    : (isDark ? AppColorsDark.inputBackground : AppColors.inputBackground),
                borderRadius: AppRadius.lgRadius,
                border: Border.all(
                  color: _captured
                      ? (isDark ? AppColorsDark.success : AppColors.success)
                      : (isDark ? AppColorsDark.border  : AppColors.border),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: _captured
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_rounded,
                          color: isDark ? AppColorsDark.success : AppColors.success,
                          size: 56),
                        const SizedBox(height: AppSpacing.md),
                        Text('Document capturé !',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: isDark ? AppColorsDark.success : AppColors.success,
                          )),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined,
                          color: isDark ? AppColorsDark.neutral400 : AppColors.neutral400,
                          size: 48),
                        const SizedBox(height: AppSpacing.md),
                        Text('Appuyez pour photographier',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
                          )),
                        const SizedBox(height: AppSpacing.xs),
                        Text('(Simulation — template)',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: isDark ? AppColorsDark.neutral400 : AppColors.neutral400,
                          )),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: AppSpacing.x2l),

          // Conseils
          _CaptureHints(isDark: isDark),
          const SizedBox(height: AppSpacing.x3l),

          if (!_captured)
            AppButton.primary(
              label:     'Prendre en photo',
              icon:      Icons.camera_alt_outlined,
              onPressed: _simulateCapture,
            ),
          const SizedBox(height: AppSpacing.x2l),
        ],
      ),
    );
  }
}

class _CaptureHints extends StatelessWidget {
  const _CaptureHints({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color:        isDark ? AppColorsDark.infoLight : AppColors.infoLight,
        borderRadius: AppRadius.mdRadius,
      ),
      child: Column(
        children: [
          ...[
            'Bonne luminosité, pas de reflets',
            'Document entier visible dans le cadre',
            'Texte lisible, pas flou',
          ].map((hint) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              children: [
                Icon(Icons.check, size: 14, color: isDark ? AppColorsDark.info : AppColors.info),
                const SizedBox(width: AppSpacing.sm),
                Text(hint, style: AppTextStyles.bodySmall.copyWith(
                  color: isDark ? AppColorsDark.infoDark : AppColors.infoDark,
                )),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

// =============================================================================
// 5. KycSelfiePage
// =============================================================================

class KycSelfiePage extends StatefulWidget {
  const KycSelfiePage({super.key});

  @override
  State<KycSelfiePage> createState() => _KycSelfiePageState();
}

class _KycSelfiePageState extends State<KycSelfiePage>
    with SingleTickerProviderStateMixin {
  bool                 _scanning  = false;
  bool                 _captured  = false;
  late AnimationController _ctrl;
  late Animation<double>   _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  void _takeSelfie() async {
    setState(() => _scanning = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() { _scanning = false; _captured = true; });
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    context.go(AppRoutes.kycProofAddress);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return _KycPageWrapper(
      step: 5, totalSteps: 6, title: 'Selfie',
      child: Column(
        children: [
          Text('Prenez un selfie',
            style: AppTextStyles.titleLarge.copyWith(
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
            )),
          const SizedBox(height: AppSpacing.xs),
          Text('Regardez la caméra et assurez-vous que votre visage est bien éclairé.',
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
            )),
          const SizedBox(height: AppSpacing.x3l),

          // Zone ovale du selfie
          Center(
            child: AnimatedBuilder(
              animation: _anim,
              builder: (_, child) => Transform.scale(
                scale: _scanning ? _anim.value : 1.0,
                child: child,
              ),
              child: Container(
                width:  200,
                height: 240,
                decoration: BoxDecoration(
                  color: _captured
                      ? (isDark ? AppColorsDark.successLight : AppColors.successLight)
                      : (isDark ? AppColorsDark.inputBackground : AppColors.inputBackground),
                  borderRadius: BorderRadius.circular(120),
                  border: Border.all(
                    color: _captured
                        ? (isDark ? AppColorsDark.success : AppColors.success)
                        : _scanning
                            ? (isDark ? AppColorsDark.primary : AppColors.primary)
                            : (isDark ? AppColorsDark.border  : AppColors.border),
                    width: 3,
                  ),
                ),
                child: Icon(
                  _captured ? Icons.check_rounded : Icons.face_outlined,
                  size:  80,
                  color: _captured
                      ? (isDark ? AppColorsDark.success : AppColors.success)
                      : (isDark ? AppColorsDark.neutral400 : AppColors.neutral400),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.x2l),

          if (_scanning)
            Text('Analyse en cours...',
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark ? AppColorsDark.primary : AppColors.primary,
              ))
          else if (_captured)
            Text('Selfie capturé !',
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark ? AppColorsDark.success : AppColors.success,
              )),

          const SizedBox(height: AppSpacing.x3l),

          if (!_scanning && !_captured)
            AppButton.primary(
              label:     'Prendre le selfie',
              icon:      Icons.camera_front_outlined,
              onPressed: _takeSelfie,
            ),
          const SizedBox(height: AppSpacing.x2l),
        ],
      ),
    );
  }
}

// =============================================================================
// 6. KycProofAddressPage
// =============================================================================

class KycProofAddressPage extends StatefulWidget {
  const KycProofAddressPage({super.key});

  @override
  State<KycProofAddressPage> createState() => _KycProofAddressPageState();
}

class _KycProofAddressPageState extends State<KycProofAddressPage> {
  String? _docType;
  bool    _uploaded = false;

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final options = ['Facture d\'eau / électricité', 'Relevé bancaire', 'Facture téléphone', 'Quittance de loyer'];

    return _KycPageWrapper(
      step: 6, totalSteps: 6, title: 'Justificatif de domicile',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Votre adresse',
            style: AppTextStyles.titleLarge.copyWith(
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
            )),
          const SizedBox(height: AppSpacing.xs),
          Text('Un document datant de moins de 3 mois.', style: AppTextStyles.bodySmall.copyWith(
            color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
          )),
          const SizedBox(height: AppSpacing.x2l),

          // Choix type
          ...options.map((opt) => _DocTypeTile(
            doc:        _DocType(id: opt, label: opt, icon: Icons.receipt_outlined),
            isSelected: _docType == opt,
            onTap:      () => setState(() => _docType = opt),
          )),

          const SizedBox(height: AppSpacing.lg),

          // Zone upload
          GestureDetector(
            onTap: () => setState(() => _uploaded = true),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width:  double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: _uploaded
                    ? (isDark ? AppColorsDark.successLight : AppColors.successLight)
                    : (isDark ? AppColorsDark.inputBackground : AppColors.inputBackground),
                borderRadius: AppRadius.lgRadius,
                border: Border.all(
                  color: _uploaded
                      ? (isDark ? AppColorsDark.success : AppColors.success)
                      : (isDark ? AppColorsDark.border  : AppColors.border),
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _uploaded ? Icons.check_circle_rounded : Icons.cloud_upload_outlined,
                    size:  36,
                    color: _uploaded
                        ? (isDark ? AppColorsDark.success : AppColors.success)
                        : (isDark ? AppColorsDark.neutral400 : AppColors.neutral400),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _uploaded ? 'Document importé !' : 'Appuyez pour importer',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: _uploaded
                          ? (isDark ? AppColorsDark.success : AppColors.success)
                          : (isDark ? AppColorsDark.textTertiary : AppColors.textTertiary),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.x3l),

          AppButton.primary(
            label:     'Soumettre',
            onPressed: (_docType != null && _uploaded)
                ? () => context.go(AppRoutes.kycSummary)
                : null,
          ),
          const SizedBox(height: AppSpacing.x2l),
        ],
      ),
    );
  }
}

// =============================================================================
// 7. KycSummaryPage
// =============================================================================

class KycSummaryPage extends StatelessWidget {
  const KycSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Résumé')),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vérifiez vos informations',
                style: AppTextStyles.titleLarge.copyWith(
                  color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                )),
              const SizedBox(height: AppSpacing.xs),
              Text('Tout est correct ?',
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                )),
              const SizedBox(height: AppSpacing.x2l),

              ...[
                ('Informations personnelles', 'Kofi Mensah — 01/01/1990', Icons.person_outline),
                ('Document d\'identité', 'Carte nationale • ****1234', Icons.badge_outlined),
                ('Selfie', 'Photo prise', Icons.face_outlined),
                ('Justificatif de domicile', 'Facture d\'eau — Oct 2024', Icons.home_outlined),
              ].map((item) => Container(
                margin:  const EdgeInsets.only(bottom: AppSpacing.md),
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color:        isDark ? AppColorsDark.surface : AppColors.surface,
                  borderRadius: AppRadius.lgRadius,
                  border: Border.all(color: isDark ? AppColorsDark.border : AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color:        isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
                        borderRadius: AppRadius.mdRadius,
                      ),
                      child: Icon(item.$3, size: 20,
                        color: isDark ? AppColorsDark.primary : AppColors.primary),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.$1, style: AppTextStyles.labelMedium.copyWith(
                          color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                        )),
                        Text(item.$2, style: AppTextStyles.titleSmall.copyWith(
                          color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                        )),
                      ],
                    )),
                    Icon(Icons.check_circle_rounded,
                      color: isDark ? AppColorsDark.success : AppColors.success,
                      size: 20),
                  ],
                ),
              )),

              const Spacer(),

              AppButton.primary(
                label:     'Envoyer ma demande',
                icon:      Icons.send_rounded,
                onPressed: () => context.go(AppRoutes.kycPending),
              ),
              const SizedBox(height: AppSpacing.x2l),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 8. KycPendingPage
// =============================================================================

class KycPendingPage extends StatefulWidget {
  const KycPendingPage({super.key});

  @override
  State<KycPendingPage> createState() => _KycPendingPageState();
}

class _KycPendingPageState extends State<KycPendingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double>   _rotateAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    _rotateAnim = Tween<double>(begin: 0, end: 1).animate(_ctrl);
    // Simulation : après 3s → succès
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.go(AppRoutes.kycSuccess);
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: _rotateAnim,
                  child: Container(
                    width: 88, height: 88,
                    decoration: BoxDecoration(
                      color:  isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
                      shape:  BoxShape.circle,
                    ),
                    child: Icon(Icons.hourglass_empty_rounded,
                      size: 44,
                      color: isDark ? AppColorsDark.primary : AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.x2l),
                Text('Vérification en cours',
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Nous analysons vos documents. Cela peut prendre quelques instants.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 9. KycSuccessPage
// =============================================================================

class KycSuccessPage extends StatelessWidget {
  const KycSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: isDark ? AppColorsDark.successLight : AppColors.successLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.verified_rounded,
                  size: 52, color: isDark ? AppColorsDark.success : AppColors.success),
              ),
              const SizedBox(height: AppSpacing.x2l),
              Text('Identité vérifiée !',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Votre compte est maintenant entièrement activé. Vous avez accès à toutes les fonctionnalités.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              AppButton.primary(
                label:     'Accéder à mon compte',
                icon:      Icons.arrow_forward_rounded,
                onPressed: () => context.go(AppRoutes.dashboard),
              ),
              const SizedBox(height: AppSpacing.x2l),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 10. KycFailedPage
// =============================================================================

class KycFailedPage extends StatelessWidget {
  const KycFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: isDark ? AppColorsDark.errorLight : AppColors.errorLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.cancel_outlined,
                  size: 52, color: isDark ? AppColorsDark.error : AppColors.error),
              ),
              const SizedBox(height: AppSpacing.x2l),
              Text('Vérification refusée',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Nous n\'avons pas pu vérifier votre identité. Vérifiez les raisons ci-dessous et réessayez.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.x2l),
              // Raisons
              ...[
                'La photo du document est floue',
                'Le selfie ne correspond pas au document',
              ].map((r) => Container(
                margin:  const EdgeInsets.only(bottom: AppSpacing.sm),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color:        isDark ? AppColorsDark.errorLight : AppColors.errorLight,
                  borderRadius: AppRadius.mdRadius,
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, size: 18,
                      color: isDark ? AppColorsDark.error : AppColors.error),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(child: Text(r, style: AppTextStyles.bodySmall.copyWith(
                      color: isDark ? AppColorsDark.errorDark : AppColors.errorDark,
                    ))),
                  ],
                ),
              )),
              const Spacer(),
              AppButton.primary(
                label:     'Réessayer',
                icon:      Icons.refresh_rounded,
                onPressed: () => context.go(AppRoutes.kycIntro),
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton.ghost(
                label:       'Contacter le support',
                onPressed:   () => context.go(AppRoutes.support),
                isFullWidth: true,
              ),
              const SizedBox(height: AppSpacing.x2l),
            ],
          ),
        ),
      ),
    );
  }
}
