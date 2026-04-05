import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';
import 'package:flutter/material.dart';

class GenericRadioSelector<T> extends StatefulWidget {
  final String title;
  final Widget? leading;
  final T? selectedOption;
  final void Function(T)? onChecked;
  final T firstValue;
  final String firstLabel;
  final T secondValue;
  final String secondLabel;

  const GenericRadioSelector({
    super.key,
    required this.title,
    this.leading,
    required this.firstValue,
    required this.firstLabel,
    required this.secondValue,
    required this.secondLabel,
    this.selectedOption,
    this.onChecked,
  });

  @override
  State<GenericRadioSelector<T>> createState() =>
      _GenericRadioSelectorState<T>();
}

class _GenericRadioSelectorState<T> extends State<GenericRadioSelector<T>> {
  T? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            widget.title,
            style: Styles.bodySmall.copyWith(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: widget.leading,
          contentPadding: const EdgeInsets.symmetric(horizontal: 2),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<T>(
                title: Text(
                  widget.firstLabel,
                  style: Styles.bodySmall.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                value: widget.firstValue,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                    if (value != null) widget.onChecked?.call(value);
                  });
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                activeColor: AppColors.primaryColor,
              ),
            ),
            Expanded(
              child: RadioListTile<T>(
                title: Text(
                  widget.secondLabel,
                  style: Styles.bodySmall.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                value: widget.secondValue,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                    if (value != null) widget.onChecked?.call(value);
                  });
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                activeColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
