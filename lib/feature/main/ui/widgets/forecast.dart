import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather/app/app.dart';
import 'package:weather/feature/feature.dart';

class ForecastContainer extends StatelessWidget {
  const ForecastContainer({
    super.key,
    required this.weatherList,
    required this.icon,
    required this.selectedWeather,
  });

  final List<WeatherModel> weatherList;
  final String Function(int) icon;
  final int selectedWeather;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color.fromRGBO(255, 255, 255, 0.20),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateFormat('EEEE', 'ru')
                      .format(DateTime.parse(weatherList[selectedWeather].dt)),
                  style: TextStyles.b1.copyWith(color: AppColors.white),
                ),
                Text(
                  DateFormat('dd MMMM', 'ru')
                      .format(DateTime.parse(weatherList[selectedWeather].dt)),
                  style: TextStyles.b2,
                ),
              ],
            ),
          ),
          Container(height: 1.0, color: AppColors.white),
          Container(
            margin: const EdgeInsets.all(16.0),
            height: 142,
            child: ListView.builder(
              itemCount: weatherList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => locator.get<MainCubit>().selectedWeather(index),
                  child: Container(
                    padding: EdgeInsets.all(
                      index == selectedWeather ? 15.0 : 16.0,
                    ),
                    width: MediaQuery.of(context).size.width / 4 - 20,
                    decoration: index == selectedWeather
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: AppColors.white),
                            color: const Color.fromRGBO(255, 255, 255, 0.40),
                          )
                        : null,
                    child: Column(
                      children: <Widget>[
                        Text(
                          DateFormat('jm', 'ru')
                              .format(DateTime.parse(weatherList[index].dt)),
                          style: TextStyles.b2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          child: Image.asset(
                            icon(weatherList[index].iconId),
                            width: 32,
                            height: 32,
                          ),
                        ),
                        Text(
                          '${weatherList[index].temp.toStringAsFixed(0)}º',
                          style: TextStyles.b2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
