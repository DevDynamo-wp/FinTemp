// =============================================================================
// verify_otp_page.dart — Vérification OTP FinTemp
// =============================================================================
// Emplacement : features/auth/presentation/pages/verify_otp/verify_otp_page.dart
//
// Page réutilisée pour :
//   - Vérification Email (après inscription)
//   - Vérification Téléphone
//   - OTP Connexion
//   - OTP Mot de passe oublié
//
// Reçoit via queryParams :
//   target  → 'email' | 'phone'
//   value   → adresse masquée (ex: 'ko***@gmail.com')
//   nextRoute → route de destination après validation
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_names.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_spacing.dart';
import '../../../../../core/design_system/buttons/app_button.dart';
import '../../../../../core/design_system/inputs/app_text_field.dart';
import '../widgets/auth_widgets.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({
    this.target    = 'email',
    this.value     = 'ko***@gmail.com',
    this.nextRoute = '/auth/password/create',
    super.key,
  });

  final String target;
  final String value;
  final String nextRoute;

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  bool  _isLoading     = false;
  bool  _isError       = false;
  int   _resendSeconds = 60;
  bool  _canResend     = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() {
        _resendSeconds--;
        if (_resendSeconds <= 0) _canResend = true;
      });
      return _resendSeconds > 0;
    });
  }

  void _onCompleted(String otp) async {
    setState(() { _isLoading = true; _isError = false; });
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;

    if (otp == '123456') { // Dummy OTP valide
      setState(() => _isLoading = false);
      context.go(widget.nextRoute);
    } else {
      setState(() { _isLoading = false; _isError = true; });
    }
  }

  void _resend() {
    setState(() { _resendSeconds = 60; _canResend = false; _isError = false; });
    _startResendTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Code renvoyé !')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final isEmail  = widget.target == 'email';

    return AuthPageWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icône
          Container(
            width:  56,
            height: 56,
            decoration: BoxDecoration(
              color:        isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isEmail ? Icons.mail_outline_rounded : Icons.sms_outlined,
              color: isDark ? AppColorsDark.primary : AppColors.primary,
              size: 28,
            ),
          ),

          const SizedBox(height: AppSpacing.x2l),

          AuthHeader(
            title:    isEmail ? 'Vérifiez votre email' : 'Vérifiez votre numéro',
            subtitle: 'Nous avons envoyé un code à 6 chiffres à\n${widget.value}',
          ),

          const SizedBox(height: AppSpacing.x4l),

          // Champ OTP
          Center(
            child: _isLoading
                ? const SizedBox(
                    height: 60,
                    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  )
                : AppPinField(
                    length:      6,
                    isError:     _isError,
                    onCompleted: _onCompleted,
                  ),
          ),

          // Erreur
          if (_isError) ...[
            const SizedBox(height: AppSpacing.md),
            Center(
              child: Text(
                'Code incorrect. Réessayez.',
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark ? AppColorsDark.error : AppColors.error,
                ),
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.x3l),

          // Renvoyer le code
          Center(
            child: _canResend
                ? GestureDetector(
                    onTap: _resend,
                    child: Text(
                      'Renvoyer le code',
                      style: AppTextStyles.labelMedium.copyWith(
                        color:      isDark ? AppColorsDark.primary : AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : RichText(
                    text: TextSpan(
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                      ),
                      children: [
                        const TextSpan(text: 'Renvoyer dans '),
                        TextSpan(
                          text:  '${_resendSeconds}s',
                          style: AppTextStyles.bodySmall.copyWith(
                            color:      isDark ? AppColorsDark.primary : AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),

          const SizedBox(height: AppSpacing.x2l),

          // Hint (pour le template)
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color:        isDark ? AppColorsDark.infoLight : AppColors.infoLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16,
                  color: isDark ? AppColorsDark.info : AppColors.info),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Template : utilisez le code 123456',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isDark ? AppColorsDark.infoDark : AppColors.infoDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
