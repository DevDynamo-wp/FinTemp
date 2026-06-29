// =============================================================================
// app_avatar.dart — Composant Avatar FinTemp
// =============================================================================
// Emplacement : core/widgets/app_avatar.dart
//
// VARIANTES :
//   AppAvatar          → avatar image ou initiales
//   AppAvatar.network  → depuis URL
//   AppAvatar.asset    → depuis assets
//
// TAILLES :
//   xs=24 · sm=32 · md=40 · lg=48 · xl=56 · x2l=72
// =============================================================================

import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';
import '../app/theme/app_text_styles.dart';
import '../app/theme/app_radius.dart';

enum AppAvatarSize { xs, sm, md, lg, xl, x2l }

extension _AppAvatarSizeX on AppAvatarSize {
  double get dimension => switch (this) {
    AppAvatarSize.xs  => 24,
    AppAvatarSize.sm  => 32,
    AppAvatarSize.md  => 40,
    AppAvatarSize.lg  => 48,
    AppAvatarSize.xl  => 56,
    AppAvatarSize.x2l => 72,
  };

  TextStyle get textStyle => switch (this) {
    AppAvatarSize.xs  => AppTextStyles.labelSmall,
    AppAvatarSize.sm  => AppTextStyles.labelMedium,
    AppAvatarSize.md  => AppTextStyles.labelLarge,
    AppAvatarSize.lg  => AppTextStyles.titleSmall,
    AppAvatarSize.xl  => AppTextStyles.titleMedium,
    AppAvatarSize.x2l => AppTextStyles.titleLarge,
  };
}

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    this.initials,
    this.imageUrl,
    this.assetPath,
    this.size = AppAvatarSize.md,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    super.key,
  });

  final String?        initials;
  final String?        imageUrl;
  final String?        assetPath;
  final AppAvatarSize  size;
  final Color?         backgroundColor;
  final Color?         foregroundColor;
  final VoidCallback?  onTap;

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final dim     = size.dimension;
    final bgColor = backgroundColor ??
        (isDark ? AppColorsDark.primarySurface : AppColors.primarySurface);
    final fgColor = foregroundColor ??
        (isDark ? AppColorsDark.primary : AppColors.primary);

    Widget avatar = Container(
      width:  dim,
      height: dim,
      decoration: BoxDecoration(
        color:  bgColor,
        shape:  BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildContent(fgColor, dim),
    );

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }

  Widget _buildContent(Color fgColor, double dim) {
    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        width: dim, height: dim, fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildInitials(fgColor),
      );
    }
    if (assetPath != null) {
      return Image.asset(
        assetPath!,
        width: dim, height: dim, fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildInitials(fgColor),
      );
    }
    return _buildInitials(fgColor);
  }

  Widget _buildInitials(Color fgColor) {
    final text = initials?.substring(0, initials!.length > 2 ? 2 : initials!.length).toUpperCase()
        ?? '?';
    return Center(
      child: Text(
        text,
        style: size.textStyle.copyWith(color: fgColor, fontWeight: FontWeight.w700),
      ),
    );
  }
}
