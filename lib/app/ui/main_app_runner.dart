import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather/app/app.dart';

class MainAppRunner implements AppRunner {
  const MainAppRunner(this.env);

  final String env;

  @override
  Future<void> preloadData() async {
    WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();

    await Firebase.initializeApp();

    ///init app
    initDi(env);

    ///init config
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    await preloadData();
    runApp(
      EasyLocalization(
        supportedLocales: <Locale>['ru'.toLocale(), 'en'.toLocale()],
        useOnlyLangCode: true,
        path: 'assets/translations',
        fallbackLocale: 'ru'.toLocale(),
        child: appBuilder.buildApp(),
      ),
    );
  }
}
