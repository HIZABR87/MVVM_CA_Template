import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/widgets/date_range_filter/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RoundedSeparateDateRangeWidget extends StatefulWidget {
  final String? initialFromDate;
  final String? initialToDate;

  final double? width;
  final double? height;

  final Function(String fromDate, String toDate) onDateRangeChanged;

  const RoundedSeparateDateRangeWidget({
    super.key,
    this.width,
    this.height,
    this.initialFromDate,
    this.initialToDate,
    required this.onDateRangeChanged,
  });

  @override
  State<RoundedSeparateDateRangeWidget> createState() =>
      _RoundedSeparateDateRangeWidgetState();
}

class _RoundedSeparateDateRangeWidgetState
    extends State<RoundedSeparateDateRangeWidget> {
  late final TextEditingController _fromDateController =
      TextEditingController(text: widget.initialFromDate);

  late final TextEditingController _toDateController =
      TextEditingController(text: widget.initialToDate);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
            title: '',
            content: DatePickerWidget(
              confirmText: 'ok'.tr,
              onFilterClick: () {
                setState(() {
                  widget.onDateRangeChanged(_fromDateController.text.trim(),
                      _toDateController.text.trim());
                });
              },
              fromDateController: _fromDateController,
              toDateController: _toDateController,
              selectionMode: DateRangePickerSelectionMode.range,
            ));
      },
      child: Container(
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AppColors.secondaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Visibility(
            visible: _fromDateController.text.isNotEmpty &&
                _toDateController.text.isNotEmpty,
            replacement: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: AppColors.secondaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'selectDate'.tr,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.secondaryColor,
                  size: 22,
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: AppColors.secondaryColor,
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _fromDateController,
                    textAlignVertical: TextAlignVertical.top,
                    enabled: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        bottom: 10,
                      ),
                    ),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                const Text(' | '),
                Expanded(
                  child: TextFormField(
                    onTap: () {},
                    controller: _toDateController,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    enabled: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        bottom: 10,
                      ),
                    ),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _fromDateController.clear();
                      _toDateController.clear();
                      widget.onDateRangeChanged(
                        _fromDateController.text.trim(),
                        _toDateController.text.trim(),
                      );
                    });
                  },
                  child: const Icon(
                    Icons.clear,
                    color: AppColors.secondaryColor,
                    size: 16,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
