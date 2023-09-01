import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/app/app.dart';
import 'package:weather/feature/feature.dart';

class WindContainer extends StatelessWidget {
  const WindContainer({super.key, required this.weather});

  final WeatherModel weather;

  String _humidity() {
    switch (weather.humidity) {
      case <= 10 && >= 22:
        return tr('humidity.dry');
      case <= 23 && >= 40:
        return tr('humidity.low');
      case <= 41 && >= 52:
        return tr('humidity.medium');
      case <= 53 && >= 64:
        return tr('humidity.habitual');
      case <= 65 && >= 73:
        return tr('humidity.moderate');
      case <= 74 && >= 81:
        return tr('humidity.high');
      case <= 82:
        return tr('humidity.foggy');
      default:
        return '';
    }
  }

  String _windDirection() {
    switch (weather.windDeg) {
      case >= 338 && <= 22:
        return tr('wind.northern');
      case >= 23 && <= 67:
        return tr('wind.northeastern');
      case >= 68 && <= 112:
        return tr('wind.oriental');
      case >= 113 && <= 157:
        return tr('wind.southeastern');
      case >= 158 && <= 202:
        return tr('wind.southern');
      case >= 203 && <= 247:
        return tr('wind.southwestern');
      case >= 248 && <= 292:
        return tr('wind.west');
      case >= 293 && <= 337:
        return tr('wind.northwestern');
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color.fromRGBO(255, 255, 255, 0.20),
      ),
      child: Column(
        children: <Widget>[
          _InfoContainer(
            icon: AppPart.icons.wind,
            info: '${weather.windSpeed} м/с',
            text: _windDirection(),
          ),
          const SizedBox(height: 16.0),
          _InfoContainer(
            icon: AppPart.icons.drop,
            info: '${weather.humidity}%',
            text: _humidity(),
          ),
        ],
      ),
    );
  }
}

class _InfoContainer extends StatelessWidget {
  const _InfoContainer({
    required this.icon,
    required this.info,
    required this.text,
  });

  final String icon;
  final String info;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(
          icon,
          width: 24.0,
          height: 24.0,
        ),
        const SizedBox(width: 8.0),
        SizedBox(
          width: 90.0,
          child: Text(
            info,
            style: TextStyles.b2Medium
                .copyWith(color: const Color.fromRGBO(255, 255, 255, 0.2)),
          ),
        ),
        Text(
          text,
          style: TextStyles.b2Medium,
        ),
      ],
    );
  }
}
