import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralAlertDialog extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final String title;
  final Widget child;
  final double height;
  final double? width;
  const GeneralAlertDialog({
    super.key,
    this.formKey,
    required this.title,
    required this.child,
    required this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: formKey,
        child: Center(
          child: SizedBox(
            width: width ?? 350,
            height: height,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// header appbar .
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// this is how geeks do balance hahahaah.
                      const Align(
                        alignment: Alignment.topRight,
                        child: Opacity(
                          opacity: 0,
                          child: IconButton(
                              onPressed: null, icon: Icon(Icons.circle)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8),
                            child: Text(
                              title,
                              style: context.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.close)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  child
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
