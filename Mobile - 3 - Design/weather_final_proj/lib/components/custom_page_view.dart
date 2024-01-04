import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_final_proj/provider/provider.dart';
import 'package:weather_final_proj/screens/current_widget.dart';
import 'package:weather_final_proj/screens/today_widget.dart';
import 'package:weather_final_proj/screens/weekly_widget.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key, required this.pageViewController});
  final PageController pageViewController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageViewController,
      children: const <Widget>[
        CurrentWeatherPage(),
        TodayWeather(),
        WeeklyWeather(),
      ],
      onPageChanged: (index) {
        context.read<MyProvider>().activePage = index;
      },
    );
  }
}
