import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

class GenericPaginationWidget extends StatefulWidget {
  final int totalPages;
  final void Function(int page)? onPageChanged;
  final int currentPage;
  const GenericPaginationWidget({
    super.key,
    required this.totalPages,
    this.onPageChanged,
    required this.currentPage,
  });

  @override
  State<GenericPaginationWidget> createState() =>
      _GenericPaginationWidgetState();
}

class _GenericPaginationWidgetState extends State<GenericPaginationWidget> {
  final NumberPaginatorController _controller = NumberPaginatorController();
  late int _currentPage;

  @override
  void initState() {
    _currentPage = widget.currentPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: NumberPaginator(
        controller: _controller,
        numberPages: widget.totalPages,
        onPageChange: (int index) {
          setState(() {
            _currentPage = index + 1;
            widget.onPageChanged?.call(_currentPage);
          });
        },
        initialPage: _currentPage - 1,
        child: SizedBox(
          height: 48,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PrevButton(),
              Flexible(
                child: ScrollableNumberContent(
                  shrinkWrap: true,
                  buttonBuilder: (context, index, isSelected) => _CustomButton(
                    onTap: () => _controller.navigateToPage(index),
                    text: '${index + 1}',
                    isSelected: isSelected,
                  ),
                ),
              ),
              const NextButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// define any custom button widget that you like
class _CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isSelected;

  const _CustomButton({
    required this.onTap,
    required this.text,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36.0),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
