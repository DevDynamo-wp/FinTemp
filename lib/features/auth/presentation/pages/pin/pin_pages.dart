// =============================================================================
// pin_pages.dart — PIN FinTemp
// =============================================================================
// Emplacement : features/auth/presentation/pages/pin/pin_pages.dart
//
// CreatePinPage  → saisie du PIN (4 chiffres)
// ConfirmPinPage → confirmation du PIN
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../core/design_system/inputs/app_text_field.dart';
import '../widgets/auth_widgets.dart';

// =============================================================================
// CreatePinPage
// =============================================================================

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  void _onPinCompleted(String pin) {
    context.push(AppRoutes.confirmPin, extra: pin);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AuthPageWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icône
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color:        isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.dialpad_rounded,
              color: isDark ? AppColorsDark.primary : AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: AppSpacing.x2l),
          const AuthHeader(
            title:    'Créer votre PIN',
            subtitle: 'Choisissez un code à 4 chiffres pour vous connecter rapidement.',
          ),
          const SizedBox(height: AppSpacing.x4l),
          Center(
            child: AppPinField(
              length:      4,
              isObscure:   true,
              onCompleted: _onPinCompleted,
            ),
          ),
          const SizedBox(height: AppSpacing.x2l),
          Center(
            child: Text(
              'N\'utilisez pas 1234 ou votre date de naissance.',
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// ConfirmPinPage
// =============================================================================

class ConfirmPinPage extends StatefulWidget {
  const ConfirmPinPage({this.originalPin = '', super.key});
  final String originalPin;

  @override
  State<ConfirmPinPage> createState() => _ConfirmPinPageState();
}

class _ConfirmPinPageState extends State<ConfirmPinPage> {
  bool _isError = false;

  void _onPinCompleted(String pin) {
    if (pin == widget.originalPin || widget.originalPin.isEmpty) {
      context.go(AppRoutes.biometric);
    } else {
      setState(() => _isError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AuthPageWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color:        isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.check_circle_outline_rounded,
              color: isDark ? AppColorsDark.primary : AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: AppSpacing.x2l),
          const AuthHeader(
            title:    'Confirmer le PIN',
            subtitle: 'Entrez à nouveau votre code PIN pour confirmer.',
          ),
          const SizedBox(height: AppSpacing.x4l),
          Center(
            child: AppPinField(
              length:      4,
              isObscure:   true,
              isError:     _isError,
              onCompleted: _onPinCompleted,
            ),
          ),
          if (_isError) ...[
            const SizedBox(height: AppSpacing.md),
            Center(
              child: Text(
                'Les codes ne correspondent pas. Réessayez.',
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark ? AppColorsDark.error : AppColors.error,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
