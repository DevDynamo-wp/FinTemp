// =============================================================================
// app_dialog.dart — Composant Dialog FinTemp
// =============================================================================
// Emplacement : core/design_system/dialogs/app_dialog.dart
//
// TYPES :
//   AppDialog.confirm   → confirmation avec 2 boutons (Annuler / Confirmer)
//   AppDialog.success   → succès avec icône verte et 1 bouton
//   AppDialog.error     → erreur avec icône rouge et 1 bouton
//   AppDialog.warning   → avertissement avec icône orange et 2 boutons
//   AppDialog.info      → information neutre
//   AppDialog.custom    → contenu libre
//
// UTILISATION :
//   AppDialog.show(context, dialog: AppDialog.confirm(...))
// =============================================================================

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_radius.dart';
import '../buttons/app_button.dart';

// =============================================================================
// AppDialog
// =============================================================================

class AppDialog extends StatelessWidget {
  const AppDialog._({
    required this.title,
    required this._type,
    this.message,
    this.content,
    this.confirmLabel   = 'Confirmer',
    this.cancelLabel    = 'Annuler',
    this.onConfirm,
    this.onCancel,
    this.isDismissible  = true,
    super.key,
  });

  // ── Constructeurs nommés ───────────────────────────────────────────────────

  factory AppDialog.confirm({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmLabel = 'Confirmer',
    String cancelLabel  = 'Annuler',
    VoidCallback? onCancel,
    Key? key,
  }) => AppDialog._(
    title: title, message: message, _type: _DialogType.confirm,
    confirmLabel: confirmLabel, cancelLabel: cancelLabel,
    onConfirm: onConfirm, onCancel: onCancel, key: key,
  );

  factory AppDialog.success({
    required String title,
    required String message,
    String confirmLabel = 'OK',
    VoidCallback? onConfirm,
    Key? key,
  }) => AppDialog._(
    title: title, message: message, _type: _DialogType.success,
    confirmLabel: confirmLabel, onConfirm: onConfirm, key: key,
  );

  factory AppDialog.error({
    required String title,
    required String message,
    String confirmLabel = 'Fermer',
    VoidCallback? onConfirm,
    Key? key,
  }) => AppDialog._(
    title: title, message: message, _type: _DialogType.error,
    confirmLabel: confirmLabel, onConfirm: onConfirm, key: key,
  );

  factory AppDialog.warning({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmLabel = 'Continuer',
    String cancelLabel  = 'Annuler',
    VoidCallback? onCancel,
    Key? key,
  }) => AppDialog._(
    title: title, message: message, _type: _DialogType.warning,
    confirmLabel: confirmLabel, cancelLabel: cancelLabel,
    onConfirm: onConfirm, onCancel: onCancel, key: key,
  );

  factory AppDialog.info({
    required String title,
    required String message,
    String confirmLabel = 'Compris',
    VoidCallback? onConfirm,
    Key? key,
  }) => AppDialog._(
    title: title, message: message, _type: _DialogType.info,
    confirmLabel: confirmLabel, onConfirm: onConfirm, key: key,
  );

  factory AppDialog.custom({
    required String title,
    required Widget content,
    String? confirmLabel,
    String? cancelLabel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDismissible = true,
    Key? key,
  }) => AppDialog._(
    title: title, _type: _DialogType.custom,
    content: content,
    confirmLabel: confirmLabel ?? 'OK',
    cancelLabel:  cancelLabel ?? 'Annuler',
    onConfirm: onConfirm, onCancel: onCancel,
    isDismissible: isDismissible, key: key,
  );

  // ── Méthode statique d'affichage ───────────────────────────────────────────

  /// Affiche le dialog.
  /// ```dart
  /// AppDialog.show(context, dialog: AppDialog.confirm(...))
  /// ```
  static Future<T?> show<T>(
    BuildContext context, {
    required AppDialog dialog,
  }) {
    return showDialog<T>(
      context:    context,
      barrierDismissible: dialog.isDismissible,
      builder:    (_) => dialog,
    );
  }

  // ── Propriétés ─────────────────────────────────────────────────────────────

  final String        title;
  final String?       message;
  final Widget?       content;
  final String        confirmLabel;
  final String        cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool          isDismissible;
  final _DialogType   _type;

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.x2l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icône
            if (_type != _DialogType.custom && _type != _DialogType.confirm) ...[
              _buildIcon(isDark),
              const SizedBox(height: AppSpacing.lg),
            ],

            // Titre
            Text(
              title,
              style: AppTextStyles.titleLarge.copyWith(
                color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),

            // Message
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // Contenu custom
            if (content != null) ...[
              const SizedBox(height: AppSpacing.lg),
              content!,
            ],

            const SizedBox(height: AppSpacing.x2l),

            // Boutons
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(bool isDark) {
    final (iconData, bgColor, iconColor) = switch (_type) {
      _DialogType.success => (
        Icons.check_circle_outline,
        isDark ? AppColorsDark.successLight : AppColors.successLight,
        isDark ? AppColorsDark.success      : AppColors.success,
      ),
      _DialogType.error => (
        Icons.error_outline,
        isDark ? AppColorsDark.errorLight : AppColors.errorLight,
        isDark ? AppColorsDark.error      : AppColors.error,
      ),
      _DialogType.warning => (
        Icons.warning_amber_outlined,
        isDark ? AppColorsDark.warningLight : AppColors.warningLight,
        isDark ? AppColorsDark.warning      : AppColors.warning,
      ),
      _DialogType.info => (
        Icons.info_outline,
        isDark ? AppColorsDark.infoLight : AppColors.infoLight,
        isDark ? AppColorsDark.info      : AppColors.info,
      ),
      _ => (Icons.help_outline, Colors.transparent, Colors.transparent),
    };

    return Container(
      width:  64,
      height: 64,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(iconData, color: iconColor, size: 32),
    );
  }

  Widget _buildActions(BuildContext context) {
    final hasCancel = _type == _DialogType.confirm || _type == _DialogType.warning ||
        (_type == _DialogType.custom && onCancel != null);

    if (!hasCancel) {
      return AppButton.primary(
        label:     confirmLabel,
        onPressed: () {
          Navigator.of(context).pop();
          onConfirm?.call();
        },
      );
    }

    return Row(
      children: [
        Expanded(
          child: AppButton.secondary(
            label:     cancelLabel,
            onPressed: () {
              Navigator.of(context).pop();
              onCancel?.call();
            },
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: (_type == _DialogType.warning)
              ? AppButton.danger(
                  label:     confirmLabel,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm?.call();
                  },
                )
              : AppButton.primary(
                  label:     confirmLabel,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm?.call();
                  },
                ),
        ),
      ],
    );
  }
}

// ── Internal ──────────────────────────────────────────────────────────────────

enum _DialogType { confirm, success, error, warning, info, custom }
