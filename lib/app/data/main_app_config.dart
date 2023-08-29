import 'package:injectable/injectable.dart';
import 'package:weather/app/app.dart';

@Singleton(as: AppConfig)
@prod
class ProdAppConfig implements AppConfig {
  @override
  String get baseUrl => 'http://api.openweathermap.org/data/2.5/';

  @override
  String get host => Environment.prod;
}

@Singleton(as: AppConfig)
@dev
class DevAppConfig implements AppConfig {
  @override
  String get baseUrl => 'http://localhost';

  @override
  String get host => Environment.dev;
}

@Singleton(as: AppConfig)
@test
class TestAppConfig implements AppConfig {
  @override
  String get baseUrl => 'http://_';

  @override
  String get host => Environment.test;
}
