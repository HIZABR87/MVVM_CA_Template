import 'package:flutter/material.dart';
import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double width;
  final double height;
  final TextStyle? style;
  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 150,
    this.height = 40,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: AppColors.primaryColor,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(52),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: style ??
              Styles.bodyLarge.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
      ),
    );
  }
}
