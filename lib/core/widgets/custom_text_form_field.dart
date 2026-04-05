import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_architecture_template/core/extensions/string_extension.dart';

class CustomTextFormField extends StatefulWidget {
  final String? title;
  final Color? colorTitle;
  final String hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final AutovalidateMode? autoValidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final List<Color>? textFieldLinearGradient;
  final TextStyle? hintStyle;
  final Color? prefixIconColor;
  final TextStyle? style;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final bool? isRequired;

  const CustomTextFormField({
    super.key,
    this.title,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.autoValidateMode,
    this.inputFormatters,
    this.width,
    this.padding,
    this.contentPadding,
    this.textFieldLinearGradient,
    this.hintStyle,
    this.prefixIconColor,
    this.style,
    this.maxLength,
    this.textCapitalization,
    this.maxLines = 1,
    this.colorTitle,
    this.isRequired,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscureText = false;
  @override
  void initState() {
    isObscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.title.isNotNull,
            child: Row(
              children: [
                Text(
                  '- ${widget.title}',
                  style: Styles.bodySmall.copyWith(
                    color: widget.colorTitle ?? AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Alexandria',
                  ),
                ),
                Visibility(
                  visible: widget.title != null,
                  child: const SizedBox(width: 2),
                ),
                Visibility(
                  visible: widget.isRequired != null,
                  child: Text(
                    '*',
                    style: Styles.labelLarge.copyWith(
                      color: AppColors.red,
                      fontFamily: 'Alexandria',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.title.isNotNull,
            child: const SizedBox(
              height: 6,
            ),
          ),
          TextFormField(
            controller: widget.controller,
            obscureText: isObscureText,
            validator: widget.validator,
            autovalidateMode: widget.autoValidateMode,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            style: widget.style ?? const TextStyle(color: AppColors.white),
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: widget.hintStyle ??
                  Styles.bodyMedium.copyWith(
                    color: AppColors.white,
                  ),
              counterStyle: const TextStyle(color: AppColors.secondaryColor),
              prefixIcon: Icon(
                widget.prefixIcon,
                color: widget.prefixIconColor ?? AppColors.white,
                size: 20,
              ),
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      onPressed: () {
                        isObscureText = !isObscureText;
                        setState(() {});
                      },
                      icon: Icon(
                        isObscureText
                            ? Icons.visibility_off
                            : widget.suffixIcon,
                        color: AppColors.white,
                        size: 20,
                      ),
                    )
                  : null,
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.gray),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              border: InputBorder.none,
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );
  }
}
