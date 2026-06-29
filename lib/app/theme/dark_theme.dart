// =============================================================================
// dark_theme.dart — Thème Sombre FinTemp
// =============================================================================
// Emplacement : app/theme/dark_theme.dart  (conforme au plan)
//
// Même structure que light_theme.dart, adaptée pour le mode sombre.
// Les couleurs de brand restent reconnaissables ; seules les surfaces changent.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';
import 'app_radius.dart';

ThemeData buildDarkTheme() {
  const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary:            AppColorsDark.primary,
    onPrimary:          AppColorsDark.textOnPrimary,
    primaryContainer:   AppColorsDark.primarySurface,
    onPrimaryContainer: AppColorsDark.primaryDark,
    secondary:            AppColorsDark.secondary,
    onSecondary:          AppColors.white,
    secondaryContainer:   AppColorsDark.secondarySurface,
    onSecondaryContainer: AppColorsDark.secondary,
    tertiary:            AppColorsDark.info,
    onTertiary:          AppColors.white,
    tertiaryContainer:   AppColorsDark.infoLight,
    onTertiaryContainer: AppColorsDark.infoDark,
    error:            AppColorsDark.error,
    onError:          AppColors.white,
    errorContainer:   AppColorsDark.errorLight,
    onErrorContainer: AppColorsDark.errorDark,
    surface:              AppColorsDark.surface,
    onSurface:            AppColorsDark.textPrimary,
    surfaceContainerHighest: AppColorsDark.neutral100,
    onSurfaceVariant:     AppColorsDark.textSecondary,
    outline:        AppColorsDark.border,
    outlineVariant: AppColorsDark.divider,
    shadow:         Colors.black,
    scrim:          AppColorsDark.overlay,
    inverseSurface:   AppColorsDark.neutral200,
    onInverseSurface: AppColorsDark.neutral900,
    inversePrimary:   AppColors.primary,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    fontFamily: 'PlusJakartaSans',
    textTheme: AppTextStyles.toTextTheme(defaultColor: AppColorsDark.textPrimary),
    scaffoldBackgroundColor: AppColorsDark.background,

    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      backgroundColor: AppColorsDark.background,
      foregroundColor: AppColorsDark.textPrimary,
      titleTextStyle: AppTextStyles.titleLarge.copyWith(color: AppColorsDark.textPrimary),
      iconTheme: const IconThemeData(color: AppColorsDark.textPrimary, size: 24),
      actionsIconTheme: const IconThemeData(color: AppColorsDark.textPrimary, size: 24),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColorsDark.surface,
      indicatorColor: AppColorsDark.primarySurface,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColorsDark.primary);
        }
        return const IconThemeData(color: AppColorsDark.neutral500);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTextStyles.labelSmall.copyWith(
            color: AppColorsDark.primary,
            fontWeight: FontWeight.w600,
          );
        }
        return AppTextStyles.labelSmall.copyWith(color: AppColorsDark.neutral500);
      }),
      height: AppSpacing.bottomNavHeight,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsDark.primary,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColorsDark.neutral200,
        disabledForegroundColor: AppColorsDark.neutral400,
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: const Size.fromHeight(AppSpacing.buttonHeightLarge),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.button),
        padding: AppSpacing.buttonLarge,
        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColorsDark.primary,
        disabledForegroundColor: AppColorsDark.textDisabled,
        side: const BorderSide(color: AppColorsDark.border),
        minimumSize: const Size.fromHeight(AppSpacing.buttonHeightLarge),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.button),
        padding: AppSpacing.buttonLarge,
        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColorsDark.primary,
        disabledForegroundColor: AppColorsDark.textDisabled,
        minimumSize: const Size(AppSpacing.minTapTarget, AppSpacing.minTapTarget),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.button),
        padding: AppSpacing.buttonMedium,
        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsDark.inputBackground,
      contentPadding: AppSpacing.inputPadding,
      border: OutlineInputBorder(borderRadius: AppRadius.input, borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: AppRadius.input, borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.input,
        borderSide: const BorderSide(color: AppColorsDark.borderFocus, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.input,
        borderSide: const BorderSide(color: AppColorsDark.borderError, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.input,
        borderSide: const BorderSide(color: AppColorsDark.borderError, width: 1.5),
      ),
      disabledBorder: OutlineInputBorder(borderRadius: AppRadius.input, borderSide: BorderSide.none),
      labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColorsDark.textSecondary),
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColorsDark.textTertiary),
      errorStyle: AppTextStyles.bodySmall.copyWith(color: AppColorsDark.error),
      prefixIconColor: AppColorsDark.neutral500,
      suffixIconColor: AppColorsDark.neutral500,
      floatingLabelStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColorsDark.primary,
        fontWeight: FontWeight.w500,
      ),
    ),

    cardTheme: const CardTheme(
      elevation: 0,
      color: AppColorsDark.surface,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    ),

    dividerTheme: const DividerThemeData(
      color: AppColorsDark.divider,
      thickness: 1,
      space: 1,
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColorsDark.primary;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(AppColors.white),
      side: const BorderSide(color: AppColorsDark.border, width: 1.5),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.xsRadius),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.white;
        return AppColorsDark.neutral500;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColorsDark.primary;
        return AppColorsDark.neutral200;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColorsDark.neutral100,
      selectedColor: AppColorsDark.primarySurface,
      labelStyle: AppTextStyles.labelMedium.copyWith(color: AppColorsDark.textPrimary),
      side: const BorderSide(color: AppColorsDark.border),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      elevation: 0,
      pressElevation: 0,
    ),

    dialogTheme: DialogTheme(
      backgroundColor: AppColorsDark.surface,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.dialog),
      titleTextStyle: AppTextStyles.titleLarge.copyWith(color: AppColorsDark.textPrimary),
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColorsDark.textSecondary),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColorsDark.surface,
      elevation: 0,
      modalBackgroundColor: AppColorsDark.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.bottomSheet),
      showDragHandle: true,
      dragHandleColor: AppColorsDark.neutral300,
      dragHandleSize: const Size(40, 4),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColorsDark.neutral200,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColorsDark.textPrimary),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdRadius),
      elevation: 0,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColorsDark.primary,
      linearTrackColor: AppColorsDark.neutral200,
      circularTrackColor: AppColorsDark.neutral200,
      linearMinHeight: 4,
      borderRadius: AppRadius.fullRadius,
    ),

    tabBarTheme: TabBarTheme(
      labelColor: AppColorsDark.primary,
      unselectedLabelColor: AppColorsDark.neutral500,
      indicatorColor: AppColorsDark.primary,
      labelStyle: AppTextStyles.labelLarge,
      unselectedLabelStyle: AppTextStyles.labelMedium,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColorsDark.primary, width: 2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.xs),
          topRight: Radius.circular(AppRadius.xs),
        ),
      ),
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Colors.transparent,
    ),

    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      minLeadingWidth: 0,
      minVerticalPadding: AppSpacing.sm,
      tileColor: Colors.transparent,
      titleTextStyle: AppTextStyles.titleMedium.copyWith(color: AppColorsDark.textPrimary),
      subtitleTextStyle: AppTextStyles.bodySmall.copyWith(color: AppColorsDark.textSecondary),
    ),

    iconTheme: const IconThemeData(color: AppColorsDark.textPrimary, size: 24),

    sliderTheme: SliderThemeData(
      activeTrackColor: AppColorsDark.primary,
      inactiveTrackColor: AppColorsDark.neutral200,
      thumbColor: AppColorsDark.primary,
      overlayColor: AppColorsDark.primary.withAlpha(30),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
    ),
  );
}