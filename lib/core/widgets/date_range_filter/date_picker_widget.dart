import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    super.key,
    required this.onFilterClick,
    required this.confirmText,
    required TextEditingController fromDateController,
    required TextEditingController toDateController,
    required this.selectionMode,
  })  : _fromDateController = fromDateController,
        _toDateController = toDateController;

  final Function onFilterClick;
  final TextEditingController _fromDateController;
  final TextEditingController _toDateController;
  final DateRangePickerSelectionMode selectionMode;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      width: 400,
      child: SfDateRangePicker(
        cancelText: 'cancel'.tr,
        showTodayButton: true,
        showActionButtons: true,
        confirmText: confirmText,
        maxDate: DateTime.now(),
        selectionMode: selectionMode,
        onCancel: () => Get.back(),
        onSubmit: (value) {
          if (value is PickerDateRange) {
            DateTime? startDate = value.startDate;
            DateTime endDate = value.endDate ?? DateTime.now();

            _fromDateController.text =
                '${startDate!.year}-${startDate.month.toString().padLeft(2, '0')}-${(startDate.day.toString().padLeft(2, '0'))}';
            _toDateController.text =
                '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';
          } else if (value is DateTime) {
            _fromDateController.text =
                '${value.year}-${value.month}-${(value.day)}';
          }
          onFilterClick();
          Get.back();
        },
        backgroundColor: Colors.transparent,
        headerStyle: DateRangePickerHeaderStyle(
          backgroundColor: Colors.transparent,
          textStyle: Styles.bodyMedium.copyWith(
            color: AppColors.secondaryColor,
          ),
        ),
        endRangeSelectionColor: AppColors.secondaryColor,
        rangeSelectionColor: AppColors.secondaryColor.withOpacity(.3),
        startRangeSelectionColor: AppColors.secondaryColor,
        selectionColor: AppColors.secondaryColor,
        todayHighlightColor: AppColors.secondaryColor,
        selectionTextStyle: Styles.bodyMedium.copyWith(
          color: AppColors.white,
        ),
        rangeTextStyle: Styles.bodyMedium.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
