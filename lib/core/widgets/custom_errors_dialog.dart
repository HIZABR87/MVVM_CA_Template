import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';
import 'package:mvvm_architecture_template/core/widgets/custom_outlined_button.dart';
import 'package:mvvm_architecture_template/core/widgets/custom_shadow_container.dart';

class CustomErrorsDialog extends StatelessWidget {
  final List<String>? errors;
  const CustomErrorsDialog({
    super.key,
    this.errors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: CustomShadowContainer(
          width: 400,
          height: 250,
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 12,
          ),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  'errorsList'.tr,
                  style: Styles.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: errors?.length,
                  itemBuilder: (context, index) => ErrorItem(
                    errorMsg: errors![index],
                  ),
                ),
              ),
              CustomOutlinedButton(
                height: 40,
                text: 'close'.tr,
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorItem extends StatelessWidget {
  final String errorMsg;
  const ErrorItem({
    super.key,
    required this.errorMsg,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.error),
      title: Text(errorMsg),
    );
  }
}
