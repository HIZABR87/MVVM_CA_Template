import 'package:mvvm_architecture_template/core/helpers/snack_bar_helper.dart';
import 'package:mvvm_architecture_template/core/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomConsumer<C extends Cubit<S>, S> extends StatelessWidget {
  final bool Function(S state) isFailure;
  final bool Function(S state)? isSuccess;
  final void Function(S state)? successFunction;
  final String Function(S state)? failureMessage;
  final bool Function(S state) isLoading;
  final double? loadingSize;
  final Widget Function(S state) builder;

  const CustomConsumer({
    super.key,
    required this.isFailure,
    this.isSuccess,
    this.failureMessage,
    this.successFunction,
    this.loadingSize,
    required this.isLoading,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<C, S>(
      listener: (context, state) {
        if (isFailure(state)) {
          SnackBarHelper.showError(
              failureMessage?.call(state) ?? 'An error occurred');
        }
        if (isSuccess != null && isSuccess!(state) && successFunction != null) {
          successFunction!(state);
        }
      },
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
