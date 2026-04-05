import 'package:mvvm_architecture_template/core/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBuilder<C extends Cubit<S>, S> extends StatelessWidget {
  final Widget Function(S state) builder;
  final bool Function(S state) isLoading;
  final double? loadingSize;

  const CustomBuilder({
    super.key,
    required this.builder,
    required this.isLoading,
    this.loadingSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      builder: (context, state) {
        if (isLoading(state)) {
          return CustomProgressIndicator(
            size: loadingSize ?? 40,
          );
        } else {
          return builder(state);
        }
      },
    );
  }
}
