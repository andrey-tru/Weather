import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather/app/app.dart';

class MainAppRunner implements AppRunner {
  const MainAppRunner(this.env);

  final String env;

  @override
  Future<void> preloadData() async {
    WidgetsFlutterBinding.ensureInitialized();

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );

    initDi(env);

    await EasyLocalization.ensureInitialized();

    await Firebase.initializeApp();

    await dotenv.load(fileName: ".env");
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
