import 'package:flutter/material.dart';
import 'package:weather/app/app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: AppColors.background,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: <Color>[
                Color.fromRGBO(7, 0, 255, 1),
                AppColors.black,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 43.0, vertical: 52.0),
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Text(
                      'WEATHER SERVICE',
                      style: TextStyles.title2,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'dawn is coming soon',
                      style: TextStyles.description,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
