import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/app/app.dart';
import 'package:weather/feature/feature.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      bloc: locator.get<MainCubit>(),
      builder: (BuildContext context, MainState state) {
        if (state.isLoading) {
          return const AppLoader();
        }
        final weather = state.weatherList![0];
        return Scaffold(
          body: ColoredBox(
            color: AppColors.background,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: <Color>[
                    Color.fromRGBO(7, 0, 255, .44),
                    AppColors.black,
                  ],
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        AppPart.image.ellipse,
                        width: 300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Архангельск, Россия',
                            style:
                                TextStyles.b2.copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: 24.0),
                          GestureDetector(
                            onTap: () => _signIn(locator.get<MainCubit>()),
                            child: SvgPicture.asset(
                              AppPart.icons.storm,
                              width: 180,
                              height: 180,
                            ),
                          ),
                          Text(
                            '${weather.temp.toStringAsFixed(0)}º',
                            style: TextStyles.title,
                          ),
                          Text(
                            weather.description[0].toUpperCase() +
                                weather.description.substring(1),
                            style:
                                TextStyles.b1.copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Макс.: ${weather.tempMax.toStringAsFixed(0)}º Мин: ${weather.tempMin.toStringAsFixed(0)}º',
                            style:
                                TextStyles.b1.copyWith(color: AppColors.white),
                          ),
                          Container(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Сегодня',
                                        style: TextStyles.b1
                                            .copyWith(color: AppColors.white),
                                      ),
                                      Text(
                                        DateFormat('dd MMMM', 'ru')
                                            .format(DateTime.parse(weather.dt)),
                                        style: TextStyles.b2
                                            .copyWith(color: AppColors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(height: 1.0, color: AppColors.white),
                                Container(
                                  margin: const EdgeInsets.all(16.0),
                                  height: 142,
                                  child: ListView.builder(
                                    itemCount: state.weatherList!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: EdgeInsets.all(
                                          index == 1 ? 15.0 : 16.0,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    4 -
                                                20,
                                        decoration: index == 1
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                border: Border.all(
                                                    color: AppColors.white),
                                                color: const Color.fromRGBO(
                                                  255,
                                                  255,
                                                  255,
                                                  0.40,
                                                ),
                                              )
                                            : null,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              DateFormat('jm', 'ru').format(
                                                  DateTime.parse(state
                                                      .weatherList![index].dt)),
                                              style: TextStyles.b2.copyWith(
                                                  color: AppColors.white),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 16.0,
                                              ),
                                              child: SvgPicture.asset(
                                                AppPart.icons.storm,
                                                width: 32,
                                                height: 32,
                                              ),
                                            ),
                                            Text(
                                              '${state.weatherList![index].temp.toStringAsFixed(0)}º',
                                              style: TextStyles.b2.copyWith(
                                                  color: AppColors.white),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color.fromRGBO(255, 255, 255, 0.20),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '20 марта',
                                      style: TextStyles.b2
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '20 марта',
                                      style: TextStyles.b2
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _signIn(MainCubit authCubit) =>
      authCubit.forecast(lat: '34.0901', lon: '-118.4065');
}
