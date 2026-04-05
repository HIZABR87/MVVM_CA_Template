import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DynamicFilterDropdown<T, F> extends StatefulWidget {
  final List<F> filterOptions;
  final String Function(F) filterLabel;
  final List<T> allItems;
  final bool Function(T item, F selectedFilter) filterCondition;
  final void Function(F?)? onChanged;
  final String hint;
  final IconData icon;
  final double? width;
  final double? height;
  final Color? borderColor;
  final F? selectedFilter;
  final bool? isShowClearButton;

  const DynamicFilterDropdown({
    super.key,
    required this.filterOptions,
    required this.filterLabel,
    required this.allItems,
    required this.filterCondition,
    this.onChanged,
    required this.hint,
    required this.icon,
    this.width,
    this.height,
    this.borderColor,
    this.selectedFilter,
    this.isShowClearButton = true,
  });

  @override
  State<DynamicFilterDropdown<T, F>> createState() =>
      _DynamicFilterDropdownState<T, F>();
}

class _DynamicFilterDropdownState<T, F>
    extends State<DynamicFilterDropdown<T, F>> {
  F? selectedFilter;

  @override
  initState() {
    super.initState();
    selectedFilter = widget.selectedFilter;
  }

  List<T> get filteredItems {
    if (selectedFilter == null) return widget.allItems;
    return widget.allItems
        .where((item) => widget.filterCondition(item, selectedFilter!))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.borderColor ?? AppColors.gray,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      width: widget.width,
      height: widget.height,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<F>(
          isExpanded: true,
          customButton: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: widget.height ?? 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // إظهار القيمة المحددة أو التلميح
                Expanded(
                  child: Row(
                    children: [
                      Icon(widget.icon,
                          color: AppColors.secondaryColor, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        selectedFilter != null
                            ? widget.filterLabel(selectedFilter!)
                            : widget.hint,
                        style: Styles.bodyMedium.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                Visibility(
                  visible: widget.isShowClearButton == true &&
                      selectedFilter != null,
                  replacement: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.secondaryColor,
                    size: 22,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = null;
                      });
                      widget.onChanged?.call(null);
                    },
                    child: const Icon(
                      Icons.clear,
                      color: AppColors.secondaryColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
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
          items: widget.filterOptions.map((filter) {
            return DropdownMenuItem<F>(
              value: filter,
              child: Text(
                widget.filterLabel(filter),
                style: Styles.bodyMedium.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            );
          }).toList(),
          value: selectedFilter,
          onChanged: (value) {
            selectedFilter = value;
            widget.onChanged?.call(value);
            setState(() {});
          },
          buttonStyleData: const ButtonStyleData(
            height: 56,
            padding: EdgeInsets.zero,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );

    /// under line dropdown filter
    // return DropdownButton2<F>(
    //   isExpanded: true,
    //   // underline: const Divider(height: 1, color: Colors.grey),
    //   hint: Row(
    //     children: [
    //       Icon(widget.icon, size: 20, color: Colors.blueGrey),
    //       const SizedBox(width: 12),
    //       Text(
    //         widget.hint,
    //         style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
    //       ),
    //     ],
    //   ),
    //   items: widget.filterOptions.map((filter) {
    //     return DropdownMenuItem<F>(
    //       value: filter,
    //       child: Text(
    //         widget.filterLabel(filter),
    //         style: const TextStyle(fontSize: 14),
    //       ),
    //     );
    //   }).toList(),
    //   value: selectedFilter,
    //   onChanged: (value) {
    //     selectedFilter = value;
    //     widget.onChanged?.call(value);
    //   },
    //   buttonStyleData: const ButtonStyleData(
    //     height: 56,
    //     padding: EdgeInsets.symmetric(horizontal: 12),
    //   ),
    //   dropdownStyleData: DropdownStyleData(
    //     maxHeight: 300,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(8),
    //       color: Colors.white,
    //     ),
    //   ),
    //   menuItemStyleData: const MenuItemStyleData(
    //     height: 40,
    //   ),
    // );
  }
}
