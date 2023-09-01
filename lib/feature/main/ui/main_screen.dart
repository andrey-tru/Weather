import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:weather/app/app.dart';
import 'package:weather/feature/feature.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final StreamController<SwipeRefreshState> _controller =
      StreamController<SwipeRefreshState>.broadcast();

  Stream<SwipeRefreshState> get _stream => _controller.stream;

  void _onRefresh(MainCubit mainCubit) => mainCubit.determinePosition();

  String icon(int id) {
    switch (id) {
      case >= 200 && < 250:
        return AppPart.image.storm;
      case >= 300 && < 350:
        return AppPart.image.shower;
      case >= 500 && < 550:
        return AppPart.image.rain;
      case >= 600 && < 650:
        return AppPart.image.snow;
      case >= 700 && < 790:
        return AppPart.image.cloudy;
      case 800:
        return AppPart.image.sun;
      case 801:
        return AppPart.image.partlyCloudy;
      case > 801 && < 850:
        return AppPart.image.cloudy;
      default:
        return AppPart.image.sun;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      bloc: locator.get<MainCubit>(),
      builder: (BuildContext context, MainState state) {
        if (state.isLoading) {
          return const AppLoader();
        }

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
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: const Alignment(0, -0.77),
                    child: Image.asset(
                      AppPart.image.ellipse,
                      width: 300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SwipeRefresh.cupertino(
                      stateStream: _stream,
                      onRefresh: () async =>
                          _onRefresh(locator.get<MainCubit>()),
                      children: <Widget>[
                        CityContainer(
                          city: state.city ?? '',
                          onTap: () => context.read<AuthCubit>().logOut(),
                        ),
                        if (state.weatherList == null ||
                            state.weatherList!.isEmpty ||
                            state.error != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 300.0),
                            child: Center(
                              child: Text(
                                state.error ?? tr('error.loading'),
                                style: TextStyles.b1Medium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        else
                          Column(
                            children: <Widget>[
                              SelectedWeatherContainer(
                                weather:
                                    state.weatherList![state.selectedWeather],
                                icon: icon(
                                  state.weatherList![state.selectedWeather]
                                      .iconId,
                                ),
                              ),
                              ForecastContainer(
                                weatherList: state.weatherList!,
                                icon: icon,
                                selectedWeather: state.selectedWeather,
                              ),
                              WindContainer(
                                weather:
                                    state.weatherList![state.selectedWeather],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
