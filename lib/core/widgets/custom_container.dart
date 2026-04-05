import 'package:flutter/material.dart';
import 'package:mvvm_architecture_template/core/extensions/color_extension.dart';

class CustomContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<Color>? linearGradientColors;
  final Color? shadowColor;
  final double? shadowSpreadRadius;
  final double? shadowBlurRadius;
  final Offset? shadowOffset;
  final Color? borderColor;
  final double? borderWidth;
  final Color? color;

  final Widget? child;
  const CustomContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.margin,
    this.child,
    this.linearGradientColors,
    this.shadowColor,
    this.shadowSpreadRadius,
    this.shadowBlurRadius,
    this.shadowOffset,
    this.borderColor,
    this.borderWidth,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        gradient: (linearGradientColors?.isNotEmpty ?? false)
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: linearGradientColors!,
              )
            : null,
        color: color,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        border: borderColor.isNotNull
            ? Border.all(
                color: borderColor!,
                width: borderWidth ?? 1,
              )
            : null,
        boxShadow: shadowColor.isNotNull
            ? [
                BoxShadow(
                  color: shadowColor!,
                  spreadRadius: shadowSpreadRadius ?? 0,
                  blurRadius: shadowBlurRadius ?? 0,
                  offset: shadowOffset ?? const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
