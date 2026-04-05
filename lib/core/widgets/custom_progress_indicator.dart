import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  const CustomProgressIndicator({
    super.key,
    this.size = 40,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SpinKitThreeBounce(
          color: color ?? AppColors.primaryColor,
          size: size,
        ),
      ),
    );
  }
}
