import 'package:flutter/material.dart';
import 'package:weather/app/app.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.blue,
        ),
      ),
    );
  }
}
