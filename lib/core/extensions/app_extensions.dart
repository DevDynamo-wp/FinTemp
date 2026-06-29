// =============================================================================
// app_extensions.dart — Extensions Dart FinTemp
// =============================================================================
// Emplacement : core/extensions/app_extensions.dart
//
// Extensions pour String, num, DateTime et BuildContext.
// Évite de dupliquer des utilitaires dans les widgets.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ── String Extensions ─────────────────────────────────────────────────────────

extension StringX on String {
  /// Capitalise la première lettre.
  /// 'hello world' → 'Hello world'
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalise chaque mot.
  /// 'hello world' → 'Hello World'
  String get titleCase => split(' ').map((w) => w.capitalize).join(' ');

  /// Masque partiellement une valeur sensible.
  /// 'test@email.com' → 'te***@email.com'
  String get maskEmail {
    final parts = split('@');
    if (parts.length != 2) return this;
    final name   = parts[0];
    final domain = parts[1];
    final masked = name.length > 2
        ? '${name.substring(0, 2)}${'*' * (name.length - 2)}'
        : name;
    return '$masked@$domain';
  }

  /// Masque un numéro de téléphone.
  /// '+22912345678' → '+229 *** ** 78'
  String get maskPhone {
    if (length < 4) return this;
    return '${substring(0, length - 4)}****${substring(length - 2)}';
  }

  /// Formate un numéro de carte bancaire avec des espaces.
  /// '1234567890123456' → '1234 5678 9012 3456'
  String get formatCardNumber {
    final digits = replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  /// Masque un numéro de carte (affiche seulement les 4 derniers chiffres).
  /// '1234567890123456' → '**** **** **** 3456'
  String get maskCardNumber {
    final digits = replaceAll(' ', '');
    if (digits.length < 4) return this;
    final last4 = digits.substring(digits.length - 4);
    return '**** **** **** $last4';
  }

  /// Vérifie si c'est un email valide.
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Vérifie si c'est un numéro de téléphone valide (format international).
  bool get isValidPhone {
    return RegExp(r'^\+?[0-9]{8,15}$').hasMatch(replaceAll(' ', ''));
  }
}

// ── num Extensions ────────────────────────────────────────────────────────────

extension NumX on num {
  /// Formate un montant en FCFA.
  /// 847200 → '847 200 FCFA'
  String toCfa({bool showSymbol = true}) {
    final formatted = NumberFormat('#,##0', 'fr_FR')
        .format(this)
        .replaceAll(',', ' ');
    return showSymbol ? '$formatted FCFA' : formatted;
  }

  /// Formate un montant en EUR.
  /// 1500.5 → '1 500,50 €'
  String toEur({bool showSymbol = true}) {
    final formatted = NumberFormat('#,##0.00', 'fr_FR').format(this);
    return showSymbol ? '$formatted €' : formatted;
  }

  /// Formate un montant en USD.
  String toUsd({bool showSymbol = true}) {
    final formatted = NumberFormat('#,##0.00', 'en_US').format(this);
    return showSymbol ? '\$$formatted' : formatted;
  }

  /// Formate un pourcentage.
  /// 12.5 → '+12,5%' ou '-3,2%'
  String toPercent({bool showSign = true}) {
    final sign = showSign && this > 0 ? '+' : '';
    return '$sign${toStringAsFixed(1)}%';
  }

  /// Raccourcit les grands nombres.
  /// 1200000 → '1,2M' | 847200 → '847K'
  String toCompact() {
    if (this >= 1000000) return '${(this / 1000000).toStringAsFixed(1)}M';
    if (this >= 1000)    return '${(this / 1000).toStringAsFixed(0)}K';
    return toString();
  }
}

// ── DateTime Extensions ───────────────────────────────────────────────────────

extension DateTimeX on DateTime {
  /// Format court : '15 jan. 2024'
  String get toShort => DateFormat('d MMM yyyy', 'fr_FR').format(this);

  /// Format long : '15 janvier 2024'
  String get toLong => DateFormat('d MMMM yyyy', 'fr_FR').format(this);

  /// Format heure : '14:32'
  String get toTime => DateFormat('HH:mm', 'fr_FR').format(this);

  /// Format complet : '15 jan. 2024 à 14:32'
  String get toFull => DateFormat("d MMM yyyy 'à' HH:mm", 'fr_FR').format(this);

  /// Format relatif : 'Aujourd\'hui', 'Hier', 'Il y a 3 jours', etc.
  String get toRelative {
    final now  = DateTime.now();
    final diff = now.difference(this);
    if (diff.inDays == 0) return 'Aujourd\'hui';
    if (diff.inDays == 1) return 'Hier';
    if (diff.inDays  < 7) return 'Il y a ${diff.inDays} jours';
    return toShort;
  }

  /// Vérifie si la date est aujourd'hui.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Vérifie si la date est hier.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }
}

// ── BuildContext Extensions ───────────────────────────────────────────────────

extension BuildContextX on BuildContext {
  // Thème
  ThemeData  get theme       => Theme.of(this);
  TextTheme  get textTheme   => Theme.of(this).textTheme;
  ColorScheme get colors     => Theme.of(this).colorScheme;
  bool        get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // MediaQuery
  Size   get screenSize   => MediaQuery.sizeOf(this);
  double get screenWidth  => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get viewPadding  => MediaQuery.viewPaddingOf(this);
  EdgeInsets get viewInsets   => MediaQuery.viewInsetsOf(this);
  bool   get isKeyboardOpen  => viewInsets.bottom > 0;

  // Navigation
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  // SnackBar
  void showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? theme.colorScheme.error
            : theme.colorScheme.primary,
      ),
    );
  }
}
