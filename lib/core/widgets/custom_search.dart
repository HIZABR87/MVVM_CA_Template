import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_architecture_template/core/colors/app_colors.dart';

class CustomSearch<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(List<T>) onItemsFiltered;
  final TextEditingController searchController;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CustomSearch({
    super.key,
    required this.items,
    required this.itemLabel,
    required this.onItemsFiltered,
    required this.searchController,
    this.padding,
    this.margin,
  });

  @override
  State<CustomSearch<T>> createState() => _CustomSearchState<T>();
}

class _CustomSearchState<T> extends State<CustomSearch<T>> {
  bool searchControllerIsNotEmpty = false;
  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_filterItems);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          colors: AppColors.searchLinearGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.15, 1],
          tileMode: TileMode.clamp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: TextField(
        controller: widget.searchController,
        decoration: InputDecoration(
          labelText: 'search'.tr,
          labelStyle: TextStyle(
            color: AppColors.gray.withOpacity(0.7),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.gray.withOpacity(0.5),
          ),
          suffixIcon: searchControllerIsNotEmpty
              ? InkWell(
                  onTap: () {
                    widget.searchController.clear();
                    setState(() {});
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColors.gray.withOpacity(0.5),
                    size: 18,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _filterItems() {
    final isNotEmptyNow = widget.searchController.text.isNotEmpty;
    if (searchControllerIsNotEmpty != isNotEmptyNow) {
      setState(() {
        searchControllerIsNotEmpty = isNotEmptyNow;
      });
    }

    final query = widget.searchController.text.toLowerCase();
    final filteredItems = widget.items
        .where((item) => widget.itemLabel(item).toLowerCase().contains(query))
        .toList();

    widget.onItemsFiltered(filteredItems);
  }
}
