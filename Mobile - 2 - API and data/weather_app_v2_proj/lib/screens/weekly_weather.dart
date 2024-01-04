import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/components/error_message.dart';
import 'package:weather_app_v2_proj/components/my_text.dart';
import 'package:weather_app_v2_proj/functions/connection.dart';
import 'package:weather_app_v2_proj/functions/helper.dart';
import 'package:weather_app_v2_proj/functions/styles.dart';
import 'package:weather_app_v2_proj/models/city.dart';
import 'package:weather_app_v2_proj/provider/provider.dart';

class WeeklyWeather extends StatelessWidget {
  const WeeklyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MyProvider>();
    final Cities city = provider.city;
    final permission = provider.permission;
    final isconnected = provider.isconnected;

    if (isconnected == false) {
      return const ErrorMessage(
          message:
              'No internet connection, please enable it in your App settings');
    }

    if (permission == false) {
      return const ErrorMessage(
          message:
              'Geolocation is not available, please enable it in your App settings');
    }

    if (city.name == '') {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyText(value: city.name, fontSize: 18),
          MyText(value: city.admin1, fontSize: 18),
          MyText(value: city.country, fontSize: 18),
          Expanded(
            child: ListView.builder(
                itemCount: city.currentWeather!.daily.time.length,
                itemBuilder: (context, index) {
                  final hourly = city.currentWeather!.hourly;
                  final daily = city.currentWeather!.daily;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        splitTime(hourly.time[index], 2),
                        style: customStyle(14),
                      ),
                      Text('${daily.temperature_2mMin[index]} °C',
                          style: customStyle(14)),
                      Text('${daily.temperature_2mMax[index]} °C',
                          style: customStyle(14)),
                      Text(getNameOfWeatherCode(daily.weathercode[index]),
                          style: customStyle(14)),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
