import 'package:flutter/material.dart';
import 'package:weather/app/app.dart';
import 'package:weather/feature/feature.dart';

class RootScreens extends StatelessWidget {
  const RootScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(
      isNotAuthorized: (BuildContext context) => LoginScreen(),
      isAuthorized: (BuildContext context) => const MainScreen(),
      isLoading: (BuildContext context) => const AppLoader(),
    );
  }
}
