import 'package:mvvm_architecture_template/core/colors/app_colors.dart';
import 'package:mvvm_architecture_template/core/styles/styles.dart';
import 'package:mvvm_architecture_template/core/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class GenericDataTable<T> extends StatefulWidget {
  const GenericDataTable({
    super.key,
    required this.items,
    required this.columns,
    required this.rowBuilder,
  });

  final List<T> items;
  final List<String> columns;
  final DataRow Function(BuildContext context, T item) rowBuilder;

  @override
  State<GenericDataTable<T>> createState() => _GenericDataTableState<T>();
}

class _GenericDataTableState<T> extends State<GenericDataTable<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: CustomContainer(
          linearGradientColors: AppColors.whiteGrayLinearGradient,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shadowColor: AppColors.black.withOpacity(.25),
          shadowBlurRadius: 4,
          child: Column(
            children: [
              DataTable(
                headingRowHeight: 30,
                dataRowMinHeight: 45,
                dataRowMaxHeight: 45,
                columnSpacing: context.isPhone ? 45 : 120,
                columns: widget.columns
                    .map(
                      (col) => DataColumn(
                        label: Expanded(
                          child: Text(
                            col.tr,
                            textAlign: TextAlign.center,
                            style: Styles.bodyMedium.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                rows: widget.items
                    .map((item) => widget.rowBuilder(context, item))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
