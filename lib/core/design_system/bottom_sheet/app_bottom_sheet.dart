// =============================================================================
// app_bottom_sheet.dart — Composant Bottom Sheet FinTemp
// =============================================================================
// Emplacement : core/design_system/bottom_sheet/app_bottom_sheet.dart
//
// TYPES :
//   AppBottomSheet.show        → contenu libre avec titre optionnel
//   AppBottomSheet.showMenu    → liste d'options avec icônes
//   AppBottomSheet.showConfirm → confirmation destructive
//
// Gère automatiquement :
//   - L'inset clavier (resizeToAvoidBottomInset)
//   - Le drag handle
//   - Le safe area bottom
//   - Le scroll si le contenu déborde
// =============================================================================

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_radius.dart';
import '../buttons/app_button.dart';

// =============================================================================
// AppBottomSheet
// =============================================================================

class AppBottomSheet {
  AppBottomSheet._();

  // ── Contenu libre ──────────────────────────────────────────────────────────

  /// Affiche un bottom sheet avec contenu libre.
  ///
  /// ```dart
  /// AppBottomSheet.show(
  ///   context,
  ///   title: 'Choisir un mode',
  ///   child: MyWidget(),
  /// )
  /// ```
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String?  title,
    bool     isDismissible   = true,
    bool     isScrollable    = false,
    double?  maxHeightFactor,
  }) {
    return showModalBottomSheet<T>(
      context:           context,
      isDismissible:     isDismissible,
      isScrollControlled: true,
      builder: (ctx) => _AppBottomSheetWrapper(
        title:            title,
        maxHeightFactor:  maxHeightFactor ?? 0.9,
        isScrollable:     isScrollable,
        child: child,
      ),
    );
  }

  // ── Menu d'options ─────────────────────────────────────────────────────────

  /// Affiche un bottom sheet avec une liste d'options.
  ///
  /// ```dart
  /// AppBottomSheet.showMenu(
  ///   context,
  ///   title: 'Actions',
  ///   items: [
  ///     AppBottomSheetItem(icon: Icons.edit, label: 'Modifier', onTap: () {}),
  ///     AppBottomSheetItem(icon: Icons.delete, label: 'Supprimer', isDestructive: true, onTap: () {}),
  ///   ],
  /// )
  /// ```
  static Future<T?> showMenu<T>(
    BuildContext context, {
    required List<AppBottomSheetItem> items,
    String? title,
  }) {
    return show<T>(
      context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) => _MenuItemTile(item: item)).toList(),
      ),
    );
  }

  // ── Confirmation destructive ───────────────────────────────────────────────

  /// Bottom sheet de confirmation pour les actions dangereuses.
  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Supprimer',
    String cancelLabel  = 'Annuler',
  }) {
    return show<bool>(
      context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColorsDark.textSecondary
                  : AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.x2l),
          AppButton.danger(
            label:     confirmLabel,
            onPressed: () => Navigator.of(context).pop(true),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton.ghost(
            label:     cancelLabel,
            onPressed: () => Navigator.of(context).pop(false),
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// _AppBottomSheetWrapper — Wrapper interne
// =============================================================================

class _AppBottomSheetWrapper extends StatelessWidget {
  const _AppBottomSheetWrapper({
    required this.child,
    required this.maxHeightFactor,
    required this.isScrollable,
    this.title,
  });

  final Widget  child;
  final String? title;
  final double  maxHeightFactor;
  final bool    isScrollable;

  @override
  Widget build(BuildContext context) {
    final isDark     = Theme.of(context).brightness == Brightness.dark;
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final maxHeight  = MediaQuery.sizeOf(context).height * maxHeightFactor;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      padding:  EdgeInsets.only(bottom: viewInsets.bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Container(
          decoration: BoxDecoration(
            color:        isDark ? AppColorsDark.surface : AppColors.surface,
            borderRadius: AppRadius.bottomSheet,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              const SizedBox(height: AppSpacing.md),
              Center(
                child: Container(
                  width:  40,
                  height: 4,
                  decoration: BoxDecoration(
                    color:        isDark ? AppColorsDark.neutral300 : AppColors.neutral300,
                    borderRadius: AppRadius.fullRadius,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Titre
              if (title != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Text(
                    title!,
                    style: AppTextStyles.titleLarge.copyWith(
                      color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Divider(
                  color: isDark ? AppColorsDark.divider : AppColors.divider,
                ),
              ],

              // Contenu
              Flexible(
                child: isScrollable
                    ? SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          AppSpacing.md,
                          AppSpacing.lg,
                          AppSpacing.lg,
                        ),
                        child: child,
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          AppSpacing.md,
                          AppSpacing.lg,
                          AppSpacing.lg,
                        ),
                        child: child,
                      ),
              ),

              // Safe area bottom
              SizedBox(height: MediaQuery.paddingOf(context).bottom),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// AppBottomSheetItem — Élément de menu
// =============================================================================

class AppBottomSheetItem {
  const AppBottomSheetItem({
    required this.label,
    required this.onTap,
    this.icon,
    this.subtitle,
    this.isDestructive = false,
    this.isEnabled     = true,
  });

  final String        label;
  final VoidCallback  onTap;
  final IconData?     icon;
  final String?       subtitle;
  final bool          isDestructive;
  final bool          isEnabled;
}

class _MenuItemTile extends StatelessWidget {
  const _MenuItemTile({required this.item});
  final AppBottomSheetItem item;

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final fgColor = item.isDestructive
        ? (isDark ? AppColorsDark.error : AppColors.error)
        : (isDark ? AppColorsDark.textPrimary : AppColors.textPrimary);

    return ListTile(
      enabled:  item.isEnabled,
      onTap:    () {
        Navigator.of(context).pop();
        item.onTap();
      },
      leading:  item.icon != null
          ? Icon(item.icon, color: fgColor, size: 22)
          : null,
      title: Text(
        item.label,
        style: AppTextStyles.bodyLarge.copyWith(color: fgColor),
      ),
      subtitle: item.subtitle != null
          ? Text(
              item.subtitle!,
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
              ),
            )
          : null,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      minLeadingWidth: AppSpacing.x2l,
    );
  }
}
