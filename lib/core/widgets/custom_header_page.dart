import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomHeaderPage extends StatelessWidget {
  final String title;
  const CustomHeaderPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.secondaryColor,
            width: 2,
          ),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: AppColors.softGray,
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Styles.titleMedium.copyWith(
          fontFamily: 'Noor',
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
