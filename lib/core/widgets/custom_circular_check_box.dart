import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomCircularCheckBox extends StatelessWidget {
  final bool isChecked;
  final Function(bool check) onChecked;
  final String title;
  const CustomCircularCheckBox({
    super.key,
    required this.isChecked,
    required this.onChecked,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            onChecked(!isChecked);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: isChecked ? AppColors.primaryColor : AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isChecked ? AppColors.primaryColor : AppColors.gray,
                width: 2,
              ),
            ),
            child: Center(
              child: isChecked
                  ? const Icon(
                      Icons.check,
                      size: 15,
                      color: AppColors.white,
                    )
                  : null,
            ),
          ),
        ),
        Text(
          title,
          style: Styles.bodySmall.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
