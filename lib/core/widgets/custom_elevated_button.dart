import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final String title;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final int? countNotification;
  const CustomElevatedButton({
    super.key,
    this.width,
    this.height,
    this.onPressed,
    this.backgroundColor,
    this.borderRadius,
    required this.title,
    this.textStyle,
    this.padding,
    this.margin,
    this.countNotification,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
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
            child: Text(
              title,
              style: textStyle ??
                  Styles.bodyLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
        Visibility(
          visible: (countNotification != null) && countNotification! > 0,
          child: Positioned(
            top: 22,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: const BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                '$countNotification',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );

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
        child: Text(
          title,
          style: textStyle ??
              Styles.bodyLarge.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
