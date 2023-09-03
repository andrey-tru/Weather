import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/app/app.dart';
import 'package:weather/feature/auth/auth.dart';

class AuthBuilder extends StatelessWidget {
  const AuthBuilder({
    super.key,
    required this.isNotAuthorized,
    required this.isAuthorized,
    required this.isLoading,
    required this.isSplash,
  });

  final WidgetBuilder isSplash;
  final WidgetBuilder isNotAuthorized;
  final WidgetBuilder isAuthorized;
  final WidgetBuilder isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return state.when(
          splash: () => isSplash(context),
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
          error: (String error) => Notifications.showSnackBar(
            context,
            ErrorModel.fromException(error),
          ),
        );
      },
    );
  }
}
