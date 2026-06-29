// =============================================================================
// login_biometric_page.dart — Connexion Biométrique FinTemp
// =============================================================================
// Emplacement : features/auth/presentation/pages/login/login_biometric_page.dart
//
// Écran de connexion rapide via Face ID ou empreinte digitale.
// Déclenche automatiquement l'authentification à l'ouverture.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../app/theme/app_radius.dart';
import '../../../../../core/design_system/buttons/app_button.dart';
import '../../../../../core/helpers/dummy_data.dart';
import '../../../../../core/widgets/app_avatar.dart';

class LoginBiometricPage extends StatefulWidget {
  const LoginBiometricPage({super.key});

  @override
  State<LoginBiometricPage> createState() => _LoginBiometricPageState();
}

class _LoginBiometricPageState extends State<LoginBiometricPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double>   _pulseAnim;

  _BiometricState _state = _BiometricState.idle;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    // Lancer l'auth biométrique automatiquement
    WidgetsBinding.instance.addPostFrameCallback((_) => _authenticate());
  }

  Future<void> _authenticate() async {
    setState(() => _state = _BiometricState.scanning);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _state = _BiometricState.success);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    context.go(AppRoutes.dashboard);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: isDark ? AppColorsDark.inputBackground : AppColors.inputBackground,
                      borderRadius: AppRadius.mdRadius,
                    ),
                    child: Icon(Icons.arrow_back_rounded,
                      color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Avatar
            AppAvatar(initials: DummyData.user.initials, size: AppAvatarSize.xl),
            const SizedBox(height: AppSpacing.md),
            Text(
              DummyData.user.fullName,
              style: AppTextStyles.titleLarge.copyWith(
                color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: AppSpacing.x4l),

            // Icône biométrique animée
            _buildBiometricIcon(isDark),

            const SizedBox(height: AppSpacing.x2l),

            Text(
              _stateLabel,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
              ),
            ),

            const Spacer(),

            Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  if (_state == _BiometricState.failed)
                    AppButton.primary(
                      label:     'Réessayer',
                      icon:      Icons.refresh_rounded,
                      onPressed: _authenticate,
                    ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton.ghost(
                    label:       'Utiliser le mot de passe',
                    onPressed:   () => context.go(AppRoutes.login),
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBiometricIcon(bool isDark) {
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;
    final bgColor = _state == _BiometricState.success
        ? (isDark ? AppColorsDark.successLight : AppColors.successLight)
        : (isDark ? AppColorsDark.primarySurface : AppColors.primarySurface);

    final iconColor = _state == _BiometricState.success
        ? (isDark ? AppColorsDark.success : AppColors.success)
        : primaryColor;

    return AnimatedBuilder(
      animation: _pulseAnim,
      builder: (_, child) => Transform.scale(
        scale: _state == _BiometricState.scanning ? _pulseAnim.value : 1.0,
        child: child,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width:  100,
        height: 100,
        decoration: BoxDecoration(
          color:  bgColor,
          shape:  BoxShape.circle,
          border: Border.all(color: iconColor.withAlpha(77), width: 2),
        ),
        child: Icon(
          _state == _BiometricState.success
              ? Icons.check_rounded
              : Icons.fingerprint_rounded,
          color: iconColor,
          size:  52,
        ),
      ),
    );
  }

  String get _stateLabel => switch (_state) {
    _BiometricState.idle     => 'Touchez le capteur d\'empreinte',
    _BiometricState.scanning => 'Vérification en cours...',
    _BiometricState.success  => 'Identité confirmée !',
    _BiometricState.failed   => 'Échec de la vérification',
  };
}

enum _BiometricState { idle, scanning, success, failed }
