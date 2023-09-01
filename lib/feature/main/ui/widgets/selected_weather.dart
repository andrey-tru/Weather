import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather/app/app.dart';
import 'package:weather/feature/feature.dart';

class SelectedWeatherContainer extends StatelessWidget {
  const SelectedWeatherContainer({
    super.key,
    required this.weather,
    required this.icon,
  });

  final WeatherModel weather;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 24.0),
        Image.asset(
          icon,
          width: 180,
          height: 180,
        ),
        Text(
          '${weather.temp.toStringAsFixed(0)}º',
          style: TextStyles.title,
        ),
        Text(
          weather.description[0].toUpperCase() +
              weather.description.substring(1),
          style: TextStyles.b1.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 8.0),
        Text(
          tr(
            'weather.maxmin',
            namedArgs: <String, String>{
              'max': weather.tempMax.toStringAsFixed(0),
              'min': weather.tempMin.toStringAsFixed(0),
            },
          ),
          style: TextStyles.b1.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}
