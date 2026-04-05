import 'package:mvvm_architecture_template/core/helpers/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomListener<C extends Cubit<S>, S> extends StatelessWidget {
  final Widget child;
  final bool Function(S state) isFailure;
  final bool Function(S state)? isSuccess;
  final void Function(S state)? successFunction;
  final String Function(S state)? failureMessage;

  const CustomListener({
    super.key,
    required this.child,
    required this.isFailure,
    this.isSuccess,
    this.failureMessage,
    this.successFunction,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, S>(
      listener: (context, state) {
        if (isFailure(state)) {
          SnackBarHelper.showError(
              failureMessage?.call(state) ?? 'An error occurred');
        }
        if (isSuccess != null && isSuccess!(state) && successFunction != null) {
          successFunction!(state);
        }
      },
      child: child,
    );
  }
}
