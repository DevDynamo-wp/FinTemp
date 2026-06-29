// =============================================================================
// light_theme.dart — Thème Clair FinTemp
// =============================================================================
// Emplacement : app/theme/light_theme.dart  (conforme au plan)
//
// Ce fichier construit le ThemeData Material 3 pour le mode clair.
// Il consomme exclusivement les tokens du Design System :
//   AppColors, AppTextStyles, AppSpacing, AppRadius, AppShadows.
//
// Jamais de couleurs ou styles en dur ici.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';
import 'app_radius.dart';

ThemeData buildLightTheme() {
  const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary:            AppColors.primary,
    onPrimary:          AppColors.textOnPrimary,
    primaryContainer:   AppColors.primarySurface,
    onPrimaryContainer: AppColors.primaryDark,
    secondary:            AppColors.secondary,
    onSecondary:          AppColors.white,
    secondaryContainer:   AppColors.secondarySurface,
    onSecondaryContainer: AppColors.secondary,
    tertiary:            AppColors.info,
    onTertiary:          AppColors.white,
    tertiaryContainer:   AppColors.infoLight,
    onTertiaryContainer: AppColors.infoDark,
    error:            AppColors.error,
    onError:          AppColors.white,
    errorContainer:   AppColors.errorLight,
    onErrorContainer: AppColors.errorDark,
    surface:              AppColors.surface,
    onSurface:            AppColors.textPrimary,
    surfaceContainerHighest: AppColors.neutral100,
    onSurfaceVariant:     AppColors.textSecondary,
    outline:        AppColors.border,
    outlineVariant: AppColors.divider,
    shadow:         AppColors.neutral900,
    scrim:          AppColors.overlay,
    inverseSurface:   AppColors.neutral800,
    onInverseSurface: AppColors.white,
    inversePrimary:   AppColors.primaryLight,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    fontFamily: 'PlusJakartaSans',
    textTheme: AppTextStyles.toTextTheme(defaultColor: AppColors.textPrimary),
    scaffoldBackgroundColor: AppColors.background,

    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      titleTextStyle: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary),
      iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
      actionsIconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primarySurface,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary);
        }
        return const IconThemeData(color: AppColors.neutral500);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTextStyles.labelSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          );
        }
        return AppTextStyles.labelSmall.copyWith(color: AppColors.neutral500);
      }),
      height: AppSpacing.bottomNavHeight,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.neutral200,
        disabledForegroundColor: AppColors.neutral400,
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
        foregroundColor: AppColors.primary,
        disabledForegroundColor: AppColors.textDisabled,
        side: const BorderSide(color: AppColors.border),
        minimumSize: const Size.fromHeight(AppSpacing.buttonHeightLarge),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.button),
        padding: AppSpacing.buttonLarge,
        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        disabledForegroundColor: AppColors.textDisabled,
        minimumSize: const Size(AppSpacing.minTapTarget, AppSpacing.minTapTarget),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.button),
        padding: AppSpacing.buttonMedium,
        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBackground,
      contentPadding: AppSpacing.inputPadding,
      border: OutlineInputBorder(borderRadius: AppRadius.input, borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: AppRadius.input, borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.input,
        borderSide: const BorderSide(color: AppColors.borderFocus, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.input,
        borderSide: const BorderSide(color: AppColors.borderError, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.input,
        borderSide: const BorderSide(color: AppColors.borderError, width: 1.5),
      ),
      disabledBorder: OutlineInputBorder(borderRadius: AppRadius.input, borderSide: BorderSide.none),
      labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary),
      errorStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
      prefixIconColor: AppColors.neutral500,
      suffixIconColor: AppColors.neutral500,
      floatingLabelStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w500,
      ),
    ),

    cardTheme: const CardTheme(
      elevation: 0,
      color: AppColors.surface,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(AppColors.white),
      side: const BorderSide(color: AppColors.border, width: 1.5),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.xsRadius),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.white;
        return AppColors.neutral400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.neutral200;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.neutral100,
      selectedColor: AppColors.primarySurface,
      labelStyle: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary),
      side: const BorderSide(color: AppColors.border),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      elevation: 0,
      pressElevation: 0,
    ),

    dialogTheme: DialogTheme(
      backgroundColor: AppColors.surface,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.dialog),
      titleTextStyle: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary),
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      elevation: 0,
      modalBackgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.bottomSheet),
      showDragHandle: true,
      dragHandleColor: AppColors.neutral300,
      dragHandleSize: const Size(40, 4),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.neutral800,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.white),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdRadius),
      elevation: 0,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.neutral200,
      circularTrackColor: AppColors.neutral200,
      linearMinHeight: 4,
      borderRadius: AppRadius.fullRadius,
    ),

    tabBarTheme: TabBarTheme(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.neutral500,
      indicatorColor: AppColors.primary,
      labelStyle: AppTextStyles.labelLarge,
      unselectedLabelStyle: AppTextStyles.labelMedium,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
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
      titleTextStyle: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary),
      subtitleTextStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
    ),

    iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),

    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.neutral200,
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primary.withAlpha(30),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
    ),
  );
}