// =============================================================================
// app_text_field.dart — Composant Champ de saisie FinTemp
// =============================================================================
// Emplacement : core/design_system/inputs/app_text_field.dart
//
// VARIANTES :
//   AppTextField            → champ standard (label flottant)
//   AppTextField.amount     → champ montant financier (gros chiffres)
//   AppTextField.password   → champ mot de passe (toggle visibilité)
//   AppTextField.phone      → champ téléphone (préfixe pays)
//   AppTextField.search     → champ recherche (icône loupe)
//   AppPinField             → champ PIN / OTP (cases séparées)
//
// ÉTATS :
//   normal · focused · error · disabled · loading
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_radius.dart';

// =============================================================================
// AppTextField
// =============================================================================

class AppTextField extends StatefulWidget {
  const AppTextField({
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.focusNode,
    super.key,
  }) : _variant = _TextFieldVariant.standard,
       _obscureText = false;

  /// Champ montant financier — grande typographie, aligné à droite.
  const AppTextField.amount({
    this.controller,
    this.label,
    this.hint = '0',
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.isEnabled = true,
    this.focusNode,
    super.key,
  }) : _variant = _TextFieldVariant.amount,
       prefixIcon = null,
       suffixIcon = null,
       onSuffixTap = null,
       onTap = null,
       keyboardType = TextInputType.number,
       textInputAction = TextInputAction.done,
       inputFormatters = const [],
       _obscureText = false,
       isReadOnly = false,
       autofocus = false,
       maxLines = 1,
       minLines = null,
       maxLength = null;

  /// Champ mot de passe — masqué avec toggle visibilité.
  const AppTextField.password({
    this.controller,
    this.label = 'Mot de passe',
    this.hint,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.isEnabled = true,
    this.focusNode,
    super.key,
  }) : _variant = _TextFieldVariant.password,
       prefixIcon = Icons.lock_outline,
       suffixIcon = null,
       onSuffixTap = null,
       onTap = null,
       keyboardType = TextInputType.visiblePassword,
       textInputAction = TextInputAction.done,
       inputFormatters = const [],
       _obscureText = true,
       isReadOnly = false,
       autofocus = false,
       maxLines = 1,
       minLines = null,
       maxLength = null;

  /// Champ recherche — style compact avec loupe.
  const AppTextField.search({
    this.controller,
    this.hint = 'Rechercher...',
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
    super.key,
  }) : _variant = _TextFieldVariant.search,
       label = null,
       helperText = null,
       errorText = null,
       prefixIcon = Icons.search,
       suffixIcon = null,
       onSuffixTap = null,
       onTap = null,
       keyboardType = TextInputType.text,
       textInputAction = TextInputAction.search,
       inputFormatters = const [],
       _obscureText = false,
       isReadOnly = false,
       isEnabled = true,
       maxLines = 1,
       minLines = null,
       maxLength = null,
       validator = null;

  // ── Propriétés ─────────────────────────────────────────────────────────────
  final TextEditingController? controller;
  final String?                label;
  final String?                hint;
  final String?                helperText;
  final String?                errorText;
  final IconData?              prefixIcon;
  final IconData?              suffixIcon;
  final VoidCallback?          onSuffixTap;
  final TextInputType?         keyboardType;
  final TextInputAction?       textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>?  onChanged;
  final ValueChanged<String>?  onSubmitted;
  final VoidCallback?          onTap;
  final FormFieldValidator<String>? validator;
  final bool                   isEnabled;
  final bool                   isReadOnly;
  final bool                   autofocus;
  final int                    maxLines;
  final int?                   minLines;
  final int?                   maxLength;
  final FocusNode?             focusNode;
  final _TextFieldVariant      _variant;
  final bool                   _obscureText;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscure   = widget._obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() => setState(() => _isFocused = _focusNode.hasFocus);

  @override
  void dispose() {
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (widget._variant == _TextFieldVariant.amount) {
      return _buildAmountField(isDark);
    }
    if (widget._variant == _TextFieldVariant.search) {
      return _buildSearchField(isDark);
    }
    return _buildStandardField(isDark);
  }

  // ── Champ standard ─────────────────────────────────────────────────────────

  Widget _buildStandardField(bool isDark) {
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller:      widget.controller,
          focusNode:       _focusNode,
          obscureText:     _obscure,
          keyboardType:    widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          enabled:         widget.isEnabled,
          readOnly:        widget.isReadOnly,
          autofocus:       widget.autofocus,
          maxLines:        widget._obscureText ? 1 : widget.maxLines,
          minLines:        widget.minLines,
          maxLength:       widget.maxLength,
          onChanged:       widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap:           widget.onTap,
          validator:       widget.validator,
          style: AppTextStyles.bodyLarge.copyWith(
            color: widget.isEnabled
                ? (isDark ? AppColorsDark.textPrimary : AppColors.textPrimary)
                : (isDark ? AppColorsDark.textDisabled : AppColors.textDisabled),
          ),
          decoration: InputDecoration(
            labelText:  widget.label,
            hintText:   widget.hint,
            errorText:  widget.errorText,
            helperText: widget.helperText,
            counterText: '',
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, size: 20)
                : null,
            suffixIcon: _buildSuffix(isDark),
          ),
        ),
      ],
    );
  }

  // ── Champ montant ──────────────────────────────────────────────────────────

  Widget _buildAmountField(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.inputBackground : AppColors.inputBackground,
        borderRadius: AppRadius.input,
        border: _isFocused
            ? Border.all(
                color: isDark ? AppColorsDark.borderFocus : AppColors.borderFocus,
                width: 1.5,
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'FCFA',
                style: AppTextStyles.titleMedium.copyWith(
                  color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextFormField(
                  controller:   widget.controller,
                  focusNode:    _focusNode,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textAlign:    TextAlign.left,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  onChanged: widget.onChanged,
                  validator: widget.validator,
                  style: AppTextStyles.displaySmall.copyWith(
                    color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText:   widget.hint ?? '0',
                    hintStyle:  AppTextStyles.displaySmall.copyWith(
                      color: isDark ? AppColorsDark.textTertiary : AppColors.textTertiary,
                    ),
                    border:           InputBorder.none,
                    enabledBorder:    InputBorder.none,
                    focusedBorder:    InputBorder.none,
                    filled:           false,
                    contentPadding:   EdgeInsets.zero,
                    isDense:          true,
                  ),
                ),
              ),
            ],
          ),
          if (widget.errorText != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              widget.errorText!,
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark ? AppColorsDark.error : AppColors.error,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Champ recherche ────────────────────────────────────────────────────────

  Widget _buildSearchField(bool isDark) {
    return TextFormField(
      controller:      widget.controller,
      focusNode:       _focusNode,
      keyboardType:    TextInputType.text,
      textInputAction: TextInputAction.search,
      autofocus:       widget.autofocus,
      onChanged:       widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      style: AppTextStyles.bodyMedium.copyWith(
        color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText:   widget.hint,
        prefixIcon: const Icon(Icons.search, size: 20),
        suffixIcon: widget.controller != null
            ? ValueListenableBuilder<TextEditingValue>(
                valueListenable: widget.controller!,
                builder: (_, value, __) {
                  if (value.text.isEmpty) return const SizedBox.shrink();
                  return GestureDetector(
                    onTap: () {
                      widget.controller!.clear();
                      widget.onChanged?.call('');
                    },
                    child: const Icon(Icons.close, size: 18),
                  );
                },
              )
            : null,
      ),
    );
  }

  // ── Suffix (password toggle ou icône custom) ───────────────────────────────

  Widget? _buildSuffix(bool isDark) {
    if (widget._variant == _TextFieldVariant.password) {
      return GestureDetector(
        onTap: () => setState(() => _obscure = !_obscure),
        child: Icon(
          _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 20,
          color: isDark ? AppColorsDark.neutral500 : AppColors.neutral500,
        ),
      );
    }

    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffixTap,
        child: Icon(widget.suffixIcon, size: 20),
      );
    }

    return null;
  }
}

// =============================================================================
// AppPinField — Champ PIN / OTP (cases séparées)
// =============================================================================

/// Champ de saisie PIN ou OTP avec cases individuelles.
///
/// ```dart
/// AppPinField(
///   length: 6,
///   onCompleted: (pin) => verifyOtp(pin),
/// )
/// ```
class AppPinField extends StatefulWidget {
  const AppPinField({
    required this.length,
    required this.onCompleted,
    this.onChanged,
    this.isObscure = false,
    this.isError = false,
    this.autofocus = true,
    super.key,
  });

  final int                   length;
  final ValueChanged<String>  onCompleted;
  final ValueChanged<String>? onChanged;
  final bool                  isObscure;
  final bool                  isError;
  final bool                  autofocus;

  @override
  State<AppPinField> createState() => _AppPinFieldState();
}

class _AppPinFieldState extends State<AppPinField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode>             _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes  = List.generate(widget.length, (_) => FocusNode());
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _focusNodes[0].requestFocus(),
      );
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes)  f.dispose();
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final pin = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(pin);

    if (pin.length == widget.length) {
      widget.onCompleted(pin);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) {
        final isActive = _focusNodes[i].hasFocus;
        final hasValue = _controllers[i].text.isNotEmpty;

        return Container(
          width: 52,
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: widget.length > 5 ? 4 : 8),
          decoration: BoxDecoration(
            color: isDark ? AppColorsDark.inputBackground : AppColors.inputBackground,
            borderRadius: AppRadius.mdRadius,
            border: Border.all(
              color: widget.isError
                  ? (isDark ? AppColorsDark.error       : AppColors.error)
                  : isActive
                      ? (isDark ? AppColorsDark.borderFocus : AppColors.borderFocus)
                      : hasValue
                          ? (isDark ? AppColorsDark.primary  : AppColors.primary)
                          : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: TextField(
            controller:   _controllers[i],
            focusNode:    _focusNodes[i],
            textAlign:    TextAlign.center,
            obscureText:  widget.isObscure,
            keyboardType: TextInputType.number,
            maxLength:    1,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (v) => _onChanged(v, i),
            style: AppTextStyles.titleLarge.copyWith(
              color: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
            ),
            decoration: const InputDecoration(
              counterText:    '',
              border:         InputBorder.none,
              enabledBorder:  InputBorder.none,
              focusedBorder:  InputBorder.none,
              filled:         false,
              contentPadding: EdgeInsets.zero,
              isDense:        true,
            ),
          ),
        );
      }),
    );
  }
}

// ── Internal ──────────────────────────────────────────────────────────────────

enum _TextFieldVariant { standard, amount, password, search }
