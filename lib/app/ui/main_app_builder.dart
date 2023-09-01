import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/app/app.dart';
import 'package:weather/feature/feature.dart';

class MainAppBuider implements AppBuilder {
  @override
  Widget buildApp() {
    return const _GlobalProviders(
      child: RootScreens(),
    );
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => locator.get<AuthCubit>()..initial(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: child,
      ),
    );
  }
}
