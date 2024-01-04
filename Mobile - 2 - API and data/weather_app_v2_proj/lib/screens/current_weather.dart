import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/components/error_message.dart';
import 'package:weather_app_v2_proj/components/my_text.dart';
import 'package:weather_app_v2_proj/functions/connection.dart';
import 'package:weather_app_v2_proj/models/city.dart';
import 'package:weather_app_v2_proj/provider/provider.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MyProvider>();
    final Cities city = provider.city;
    final Weather? curr = city.currentWeather?.currentWeather;
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
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
          child: ListTile(
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              city.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            MyText(value: city.admin1, fontSize: 18),
            MyText(value: city.country, fontSize: 18),
            MyText(
                value: getNameOfWeatherCode(curr!.weathercode), fontSize: 18),
            MyText(value: '${curr.temperature} °C', fontSize: 18),
            MyText(value: '${curr.windspeed} km/h', fontSize: 18),
          ],
        ),
      )),
    );
  }
}
