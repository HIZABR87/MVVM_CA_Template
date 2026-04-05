import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;
  final EdgeInsetsGeometry? padding;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = '',
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          Text(
            label,
            style: Styles.bodyMedium.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primaryColor,
              inactiveThumbColor: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
