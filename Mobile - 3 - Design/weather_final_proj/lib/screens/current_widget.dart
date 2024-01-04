import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_final_proj/components/error_message.dart';
import 'package:weather_final_proj/components/lottie_image.dart';
import 'package:weather_final_proj/functions/connection.dart';
import 'package:weather_final_proj/functions/styles.dart';
import 'package:weather_final_proj/models/city.dart';
import 'package:weather_final_proj/provider/provider.dart';

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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              city.name,
              textAlign: TextAlign.center,
              style: customStyle(18, Colors.lightBlueAccent),
            ),
            Text('${city.admin1}, ${city.country}',
                textAlign: TextAlign.center,
                style: customStyle(18, Colors.white)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${curr!.temperature} °C',
                style: customStyle(36, Colors.yellow)),
            Text(
                getNameOfWeatherCode(
                        city.currentWeather!.currentWeather.weathercode)['name']
                    .toString(),
                style: customStyle(18, Colors.white)),
            const SizedBox(height: 15),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: CustomLottie(
                  code: city.currentWeather!.currentWeather.weathercode),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wind_power, color: Colors.lightBlueAccent),
                const SizedBox(width: 10),
                Text('${curr.windspeed} km/h',
                    style: customStyle(18, Colors.white)),
              ],
            ),
          ],
        )
      ],
    );
  }
}
