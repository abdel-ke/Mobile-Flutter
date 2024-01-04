import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_final_proj/components/error_message.dart';
import 'package:weather_final_proj/components/lottie_image.dart';
import 'package:weather_final_proj/functions/helper.dart';
import 'package:weather_final_proj/functions/styles.dart';
import 'package:weather_final_proj/models/city.dart';
import 'package:weather_final_proj/provider/provider.dart';

class ChartData {
  ChartData(this.time, this.tempurature2d);
  final String time;
  final double? tempurature2d;
}

class TodayWeather extends StatefulWidget {
  const TodayWeather({super.key});

  @override
  State<TodayWeather> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

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

    List<ChartData> chartDataList = [];
    for (int i = 0; i <= 23; i++) {
      chartDataList.add(
        ChartData(splitTime(city.currentWeather!.hourly.time[i], 1),
            city.currentWeather!.hourly.temperature2m[i]),
      );
    }

    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            city.name,
            style: customStyle(18, Colors.lightBlueAccent),
          ),
          Text('${city.admin1}, ${city.country}',
              style: customStyle(18, Colors.white)),
        ],
      ),
      SfCartesianChart(
        plotAreaBackgroundColor: Colors.transparent,
        title: ChartTitle(
            text: 'Today tempuratures',
            textStyle: const TextStyle(color: Colors.white)),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          LineSeries<ChartData, String>(
            color: Colors.yellow,
            name: "Time",
            dataSource: chartDataList,
            xValueMapper: (ChartData data, _) => data.time,
            yValueMapper: (ChartData data, _) => data.tempurature2d,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            markerSettings: const MarkerSettings(isVisible: true),
          ),
        ],
        primaryYAxis: NumericAxis(
            interval: 5,
            labelFormat: '{value}°C',
            labelStyle: const TextStyle(color: Colors.white)),
        primaryXAxis:
            CategoryAxis(labelStyle: const TextStyle(color: Colors.white)),
      ),
      SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: city.currentWeather!.hourly.time.length ~/ 7,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 180,
              margin: const EdgeInsets.all(5.0),
              color: Colors.grey.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    splitTime(city.currentWeather!.hourly.time[index], 1),
                    style: customStyle(18, Colors.white),
                  ),
                  CustomLottie(
                      code:
                          city.currentWeather!.currentWeather.weathercode),
                  Text(
                    '${city.currentWeather!.hourly.temperature2m[index].toString()}°C',
                    style: customStyle(18, Colors.yellow.shade700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wind_power,
                          color: Colors.lightBlueAccent),
                      const SizedBox(width: 10),
                      Text(
                          '${city.currentWeather!.hourly.windspeed10m[index]} km/h',
                          style: customStyle(18, Colors.white)),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ]);
  }
}
