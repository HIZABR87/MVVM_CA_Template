import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBorderPage extends StatelessWidget {
  final Widget? child;
  const CustomBorderPage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.secondaryColor,
          width: 2,
        ),
      ),
      child: child,
    );
  }
}
