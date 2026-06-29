// =============================================================================
// app_button.dart — Composant Bouton FinTemp
// =============================================================================
// Emplacement : core/design_system/buttons/app_button.dart
//
// VARIANTES :
//   AppButton.primary   → bouton principal plein (CTA principal)
//   AppButton.secondary → bouton secondaire outline
//   AppButton.ghost     → bouton texte sans fond
//   AppButton.danger    → bouton destructif (rouge)
//   AppButton.icon      → bouton icône rond
//
// TAILLES :
//   AppButtonSize.large  → 56px hauteur (actions principales)
//   AppButtonSize.medium → 48px hauteur (actions secondaires)
//   AppButtonSize.small  → 36px hauteur (actions compactes)
//
// ÉTATS :
//   normal · loading · disabled
//
// RÈGLE : Ce widget consomme exclusivement les tokens du Design System.
//         Aucune couleur ou style en dur.
// =============================================================================

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_radius.dart';

// ── Tailles disponibles ───────────────────────────────────────────────────────

enum AppButtonSize { large, medium, small }

extension _AppButtonSizeX on AppButtonSize {
  double get height {
    switch (this) {
      case AppButtonSize.large:  return AppSpacing.buttonHeightLarge;
      case AppButtonSize.medium: return AppSpacing.buttonHeightMedium;
      case AppButtonSize.small:  return AppSpacing.buttonHeightSmall;
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case AppButtonSize.large:  return AppSpacing.buttonLarge;
      case AppButtonSize.medium: return AppSpacing.buttonMedium;
      case AppButtonSize.small:  return AppSpacing.buttonSmall;
    }
  }

  TextStyle get textStyle {
    switch (this) {
      case AppButtonSize.large:  return AppTextStyles.labelLarge;
      case AppButtonSize.medium: return AppTextStyles.labelLarge;
      case AppButtonSize.small:  return AppTextStyles.labelMedium;
    }
  }

  double get iconSize {
    switch (this) {
      case AppButtonSize.large:  return 20;
      case AppButtonSize.medium: return 18;
      case AppButtonSize.small:  return 16;
    }
  }
}

// =============================================================================
// AppButton
// =============================================================================

/// Composant bouton universel de FinTemp.
///
/// Exemples d'utilisation :
/// ```dart
/// // Bouton principal
/// AppButton.primary(label: 'Envoyer', onPressed: () {})
///
/// // Bouton avec icône et état loading
/// AppButton.primary(
///   label: 'Transférer',
///   icon: Icons.send,
///   isLoading: true,
///   onPressed: () {},
/// )
///
/// // Bouton outline
/// AppButton.secondary(label: 'Annuler', onPressed: () {})
///
/// // Bouton icône rond
/// AppButton.icon(icon: Icons.add, onPressed: () {})
/// ```
class AppButton extends StatelessWidget {
  const AppButton._({
    required this.label,
    required this.onPressed,
    required this._variant,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.size = AppButtonSize.large,
    super.key,
  });

  // ── Constructeurs nommés ───────────────────────────────────────────────────

  /// Bouton principal — fond vert, texte blanc.
  factory AppButton.primary({
    required String label,
    required VoidCallback? onPressed,
    IconData? icon,
    IconData? trailingIcon,
    bool isLoading = false,
    bool isFullWidth = true,
    AppButtonSize size = AppButtonSize.large,
    Key? key,
  }) =>
      AppButton._(
        label: label,
        onPressed: onPressed,
        _variant: _ButtonVariant.primary,
        icon: icon,
        trailingIcon: trailingIcon,
        isLoading: isLoading,
        isFullWidth: isFullWidth,
        size: size,
        key: key,
      );

  /// Bouton secondaire — outline vert, texte vert.
  factory AppButton.secondary({
    required String label,
    required VoidCallback? onPressed,
    IconData? icon,
    IconData? trailingIcon,
    bool isLoading = false,
    bool isFullWidth = true,
    AppButtonSize size = AppButtonSize.large,
    Key? key,
  }) =>
      AppButton._(
        label: label,
        onPressed: onPressed,
        _variant: _ButtonVariant.secondary,
        icon: icon,
        trailingIcon: trailingIcon,
        isLoading: isLoading,
        isFullWidth: isFullWidth,
        size: size,
        key: key,
      );

  /// Bouton ghost — transparent, texte vert.
  factory AppButton.ghost({
    required String label,
    required VoidCallback? onPressed,
    IconData? icon,
    IconData? trailingIcon,
    bool isLoading = false,
    bool isFullWidth = false,
    AppButtonSize size = AppButtonSize.medium,
    Key? key,
  }) =>
      AppButton._(
        label: label,
        onPressed: onPressed,
        _variant: _ButtonVariant.ghost,
        icon: icon,
        trailingIcon: trailingIcon,
        isLoading: isLoading,
        isFullWidth: isFullWidth,
        size: size,
        key: key,
      );

  /// Bouton danger — fond rouge, texte blanc.
  factory AppButton.danger({
    required String label,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = true,
    AppButtonSize size = AppButtonSize.large,
    Key? key,
  }) =>
      AppButton._(
        label: label,
        onPressed: onPressed,
        _variant: _ButtonVariant.danger,
        icon: icon,
        isLoading: isLoading,
        isFullWidth: isFullWidth,
        size: size,
        key: key,
      );

  // ── Propriétés ─────────────────────────────────────────────────────────────

  final String          label;
  final VoidCallback?   onPressed;
  final _ButtonVariant  _variant;
  final IconData?       icon;
  final IconData?       trailingIcon;
  final bool            isLoading;
  final bool            isFullWidth;
  final AppButtonSize   size;

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final isEnabled = onPressed != null && !isLoading;

    final colors   = _resolveColors(isDark, isEnabled);
    final minWidth = isFullWidth ? double.infinity : 0.0;

    final child = AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isLoading
          ? _buildLoader(colors.foreground)
          : _buildContent(colors.foreground),
    );

    switch (_variant) {
      case _ButtonVariant.primary:
      case _ButtonVariant.danger:
        return SizedBox(
          width:  isFullWidth ? double.infinity : null,
          height: size.height,
          child: ElevatedButton(
            onPressed: isEnabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:         colors.background,
              foregroundColor:         colors.foreground,
              disabledBackgroundColor: colors.disabledBg,
              disabledForegroundColor: colors.disabledFg,
              minimumSize:   Size(minWidth, size.height),
              padding:       size.padding,
              shape: const RoundedRectangleBorder(borderRadius: AppRadius.button),
              elevation:   0,
              shadowColor: Colors.transparent,
            ),
            child: child,
          ),
        );

      case _ButtonVariant.secondary:
        return SizedBox(
          width:  isFullWidth ? double.infinity : null,
          height: size.height,
          child: OutlinedButton(
            onPressed: isEnabled ? onPressed : null,
            style: OutlinedButton.styleFrom(
              foregroundColor:         colors.foreground,
              disabledForegroundColor: colors.disabledFg,
              side: BorderSide(
                color: isEnabled ? colors.border : colors.disabledFg,
              ),
              minimumSize: Size(minWidth, size.height),
              padding:     size.padding,
              shape: const RoundedRectangleBorder(borderRadius: AppRadius.button),
            ),
            child: child,
          ),
        );

      case _ButtonVariant.ghost:
        return SizedBox(
          width:  isFullWidth ? double.infinity : null,
          height: size.height,
          child: TextButton(
            onPressed: isEnabled ? onPressed : null,
            style: TextButton.styleFrom(
              foregroundColor:         colors.foreground,
              disabledForegroundColor: colors.disabledFg,
              minimumSize: Size(minWidth, size.height),
              padding:     size.padding,
              shape: const RoundedRectangleBorder(borderRadius: AppRadius.button),
            ),
            child: child,
          ),
        );
    }
  }

  // ── Contenu du bouton ──────────────────────────────────────────────────────

  Widget _buildContent(Color fgColor) {
    if (icon == null && trailingIcon == null) {
      return Text(label, style: size.textStyle.copyWith(color: fgColor));
    }

    return Row(
      mainAxisSize:     MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: size.iconSize, color: fgColor),
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(label, style: size.textStyle.copyWith(color: fgColor)),
        if (trailingIcon != null) ...[
          const SizedBox(width: AppSpacing.sm),
          Icon(trailingIcon, size: size.iconSize, color: fgColor),
        ],
      ],
    );
  }

  Widget _buildLoader(Color fgColor) {
    return SizedBox(
      width:  size.iconSize,
      height: size.iconSize,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: fgColor,
      ),
    );
  }

  // ── Couleurs selon variante + thème ───────────────────────────────────────

  _ButtonColors _resolveColors(bool isDark, bool isEnabled) {
    switch (_variant) {
      case _ButtonVariant.primary:
        return _ButtonColors(
          background:  isDark ? AppColorsDark.primary    : AppColors.primary,
          foreground:  AppColors.white,
          border:      Colors.transparent,
          disabledBg:  isDark ? AppColorsDark.neutral200 : AppColors.neutral200,
          disabledFg:  isDark ? AppColorsDark.neutral400 : AppColors.neutral400,
        );

      case _ButtonVariant.secondary:
        return _ButtonColors(
          background:  Colors.transparent,
          foreground:  isDark ? AppColorsDark.primary    : AppColors.primary,
          border:      isDark ? AppColorsDark.border     : AppColors.border,
          disabledBg:  Colors.transparent,
          disabledFg:  isDark ? AppColorsDark.textDisabled : AppColors.textDisabled,
        );

      case _ButtonVariant.ghost:
        return _ButtonColors(
          background:  Colors.transparent,
          foreground:  isDark ? AppColorsDark.primary    : AppColors.primary,
          border:      Colors.transparent,
          disabledBg:  Colors.transparent,
          disabledFg:  isDark ? AppColorsDark.textDisabled : AppColors.textDisabled,
        );

      case _ButtonVariant.danger:
        return _ButtonColors(
          background:  isDark ? AppColorsDark.error    : AppColors.error,
          foreground:  AppColors.white,
          border:      Colors.transparent,
          disabledBg:  isDark ? AppColorsDark.neutral200 : AppColors.neutral200,
          disabledFg:  isDark ? AppColorsDark.neutral400 : AppColors.neutral400,
        );
    }
  }
}

// =============================================================================
// AppIconButton — Bouton icône rond
// =============================================================================

/// Bouton icône rond, utilisé pour les actions rapides (FAB-like, actions de carte).
///
/// ```dart
/// AppIconButton(
///   icon: Icons.add,
///   onPressed: () {},
///   label: 'Ajouter',
/// )
/// ```
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.onPressed,
    this.label,
    this.size = 48,
    this.iconSize = 22,
    this.variant = AppIconButtonVariant.primary,
    super.key,
  });

  final IconData             icon;
  final VoidCallback?        onPressed;
  final String?              label;
  final double               size;
  final double               iconSize;
  final AppIconButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = switch (variant) {
      AppIconButtonVariant.primary   => isDark ? AppColorsDark.primary        : AppColors.primary,
      AppIconButtonVariant.surface   => isDark ? AppColorsDark.inputBackground : AppColors.inputBackground,
      AppIconButtonVariant.outlined  => Colors.transparent,
      AppIconButtonVariant.ghost     => Colors.transparent,
    };

    final fgColor = switch (variant) {
      AppIconButtonVariant.primary   => AppColors.white,
      AppIconButtonVariant.surface   => isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      AppIconButtonVariant.outlined  => isDark ? AppColorsDark.primary     : AppColors.primary,
      AppIconButtonVariant.ghost     => isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
    };

    final borderColor = switch (variant) {
      AppIconButtonVariant.outlined => isDark ? AppColorsDark.border : AppColors.border,
      _ => Colors.transparent,
    };

    final button = GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width:  size,
        height: size,
        decoration: BoxDecoration(
          color:  bgColor,
          shape:  BoxShape.circle,
          border: Border.all(color: borderColor),
        ),
        child: Icon(icon, size: iconSize, color: fgColor),
      ),
    );

    if (label == null) return button;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        button,
        const SizedBox(height: AppSpacing.xs),
        Text(
          label!,
          style: AppTextStyles.labelSmall.copyWith(
            color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

enum AppIconButtonVariant { primary, surface, outlined, ghost }

// ── Internals ─────────────────────────────────────────────────────────────────

enum _ButtonVariant { primary, secondary, ghost, danger }

class _ButtonColors {
  const _ButtonColors({
    required this.background,
    required this.foreground,
    required this.border,
    required this.disabledBg,
    required this.disabledFg,
  });
  final Color background;
  final Color foreground;
  final Color border;
  final Color disabledBg;
  final Color disabledFg;
}
