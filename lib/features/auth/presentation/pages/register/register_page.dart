// =============================================================================
// register_page.dart — Création de compte FinTemp
// =============================================================================
// Emplacement : features/auth/presentation/pages/register/register_page.dart
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey      = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl  = TextEditingController();
  final _emailCtrl    = TextEditingController();
  final _phoneCtrl    = TextEditingController();
  bool  _isLoading    = false;
  bool  _acceptTerms  = false;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez accepter les conditions d\'utilisation')),
      );
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.go(AppRoutes.verifyEmail);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AuthPageWrapper(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthHeader(
              title:    'Créer un compte',
              subtitle: 'Renseignez vos informations pour commencer.',
            ),

            const SizedBox(height: AppSpacing.x3l),

            // Prénom + Nom (côte à côte)
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller:      _firstNameCtrl,
                    label:           'Prénom',
                    hint:            'Kofi',
                    prefixIcon:      Icons.person_outline_rounded,
                    textInputAction: TextInputAction.next,
                    validator: (v) => v == null || v.isEmpty ? 'Requis' : null,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppTextField(
                    controller:      _lastNameCtrl,
                    label:           'Nom',
                    hint:            'Mensah',
                    textInputAction: TextInputAction.next,
                    validator: (v) => v == null || v.isEmpty ? 'Requis' : null,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            AppTextField(
              controller:      _emailCtrl,
              label:           'Email',
              hint:            'kofi@example.com',
              prefixIcon:      Icons.mail_outline_rounded,
              keyboardType:    TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email requis';
                if (!v.contains('@')) return 'Email invalide';
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.md),

            AppTextField(
              controller:      _phoneCtrl,
              label:           'Téléphone',
              hint:            '+229 97 00 00 00',
              prefixIcon:      Icons.phone_outlined,
              keyboardType:    TextInputType.phone,
              textInputAction: TextInputAction.done,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Téléphone requis';
                if (v.replaceAll(' ', '').length < 8) return 'Numéro invalide';
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.x2l),

            // Checkbox conditions
            GestureDetector(
              onTap: () => setState(() => _acceptTerms = !_acceptTerms),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width:  24,
                    height: 24,
                    child: Checkbox(
                      value:    _acceptTerms,
                      onChanged: (v) => setState(() => _acceptTerms = v ?? false),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                        ),
                        children: [
                          const TextSpan(text: 'J\'accepte les '),
                          TextSpan(
                            text:  'Conditions d\'utilisation',
                            style: AppTextStyles.bodySmall.copyWith(
                              color:      isDark ? AppColorsDark.primary : AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: ' et la '),
                          TextSpan(
                            text:  'Politique de confidentialité',
                            style: AppTextStyles.bodySmall.copyWith(
                              color:      isDark ? AppColorsDark.primary : AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.x2l),

            AppButton.primary(
              label:     'Créer mon compte',
              isLoading: _isLoading,
              onPressed: _submit,
            ),

            const SizedBox(height: AppSpacing.x2l),

            const AuthDivider(),
            const SizedBox(height: AppSpacing.x2l),
            const AuthSocialButtons(),
            const SizedBox(height: AppSpacing.x3l),

            AuthFooterLink(
              text:     'Déjà un compte ?',
              linkText: 'Connexion',
              onTap:    () => context.go(AppRoutes.login),
            ),

            const SizedBox(height: AppSpacing.x2l),
          ],
        ),
      ),
    );
  }
}
