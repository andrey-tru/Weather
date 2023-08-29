import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/feature/auth/auth.dart';

class AuthBuilder extends StatelessWidget {
  const AuthBuilder({
    super.key,
    required this.isNotAuthorized,
    required this.isAuthorized,
    required this.isLoading,
  });

  final WidgetBuilder isNotAuthorized;
  final WidgetBuilder isAuthorized;
  final WidgetBuilder isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return state.when(
          notAuthorization: () => isNotAuthorized(context),
          authorization: () => isAuthorized(context),
          loading: () => isLoading(context),
          error: (String error) => isNotAuthorized(context),
        );
      },
      listenWhen: (AuthState previous, AuthState current) =>
          previous.mapOrNull(
            error: (dynamic value) => value,
          ) !=
          current.mapOrNull(
            error: (dynamic value) => value,
          ),
      listener: (BuildContext context, AuthState state) {
        state.whenOrNull(
          error: (String error) => _showSnackBar(context, error),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: SingleChildScrollView(
          child: Text(error),
        ),
      ),
    );
  }
}
