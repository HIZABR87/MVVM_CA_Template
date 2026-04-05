import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/extensions/build_context_extension.dart';
import 'package:mvvm_architecture_template/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final double? height;
  const CustomBottomNavigationBar({
    super.key,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? context.dynamicHeight(.1),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: Center(
        child: CustomElevatedButton(
          title: 'back'.tr,
          width: 150,
          height: 40,
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }
}
