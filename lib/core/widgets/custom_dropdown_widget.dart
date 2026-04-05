import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';
import 'package:mvvm_architecture_template/core/widgets/custom_progress_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T?) onChanged;
  final void Function()? onMenuStateChange;
  final void Function()? initData;
  final T? selectedValue;
  final String hint;
  final IconData icon;
  final String? title;
  final bool? isRequired;
  final bool isLoading;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.selectedValue,
    this.hint = 'selectItem',
    required this.icon,
    this.onMenuStateChange,
    this.title,
    this.isRequired,
    this.initData,
    this.isLoading = true,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    widget.initData?.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Visibility(
              visible: widget.title != null,
              child: Text(
                '- ${widget.title}',
                style: Styles.bodySmall.copyWith(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Alexandria',
                ),
              ),
            ),
            Visibility(
              visible: widget.title != null,
              child: const SizedBox(width: 2),
            ),
            Visibility(
              visible: widget.isRequired != null,
              child: Text(
                '*',
                style: Styles.labelLarge.copyWith(
                  color: AppColors.red,
                  fontFamily: 'Alexandria',
                ),
              ),
            ),
          ],
        ),
        DropdownButton2<T>(
          isExpanded: true,
          underline: const Divider(
            height: 1,
            color: AppColors.gray,
          ),
          hint: Row(
            children: [
              Icon(
                widget.icon,
                color: AppColors.secondaryColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                widget.hint,
                style: Styles.bodyMedium.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
          disabledHint: widget.isLoading
              ? Row(
                  children: [
                    Icon(
                      widget.icon,
                      color: AppColors.secondaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'جاري التحميل...',
                      style: Styles.bodyMedium.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                )
              : null,
          items: widget.items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      widget.itemLabel(item),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ))
              .toList(),
          value: widget.selectedValue,
          onChanged: widget.onChanged,
          style: Styles.bodyMedium.copyWith(
            color: AppColors.secondaryColor,
            fontFamily: 'Alexandria',
          ),
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 0,
            ),
            height: 56,
          ),
          dropdownStyleData: const DropdownStyleData(maxHeight: 400),
          menuItemStyleData: const MenuItemStyleData(height: 40),
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  hintText: 'search'.tr,
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              if (item.value == null) {
                return false;
              }
              return widget
                  .itemLabel(item.value!)
                  .toLowerCase()
                  .contains(searchValue.toLowerCase());
            },
          ),
          onMenuStateChange: (isOpen) {
            if (isOpen) {
              widget.onMenuStateChange?.call();
            } else {
              textEditingController.clear();
            }
          },
          iconStyleData: IconStyleData(
            icon: widget.items.isNotEmpty || !widget.isLoading
                ? const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.secondaryColor,
                    size: 24,
                  )
                : const CustomProgressIndicator(
                    size: 12,
                    color: AppColors.secondaryColor,
                  ),
          ),
        ),
      ],
    );
  }
}
