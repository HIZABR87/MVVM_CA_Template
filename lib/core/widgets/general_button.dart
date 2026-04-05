import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  final double? width;
  final double? height;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  const GeneralButton({
    super.key,
    this.width,
    this.height,
    this.onPressed,
    this.backgroundColor,
    this.borderRadius,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            backgroundColor ?? AppColors.primaryColor,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(36),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
