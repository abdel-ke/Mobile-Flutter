import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_final_proj/components/error_message.dart';
import 'package:weather_final_proj/components/lottie_image.dart';
import 'package:weather_final_proj/functions/styles.dart';
import 'package:weather_final_proj/models/city.dart';
import 'package:weather_final_proj/provider/provider.dart';
import 'package:intl/intl.dart';

class WeeklyWeather extends StatefulWidget {
  const WeeklyWeather({super.key});

  @override
  State<WeeklyWeather> createState() => _WeeklyWeatherState();
}

class _WeeklyWeatherState extends State<WeeklyWeather> {
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
    final Daily? weekly = provider.city.currentWeather?.daily;
    final permission = provider.permission;
    final isconnected = provider.isconnected;

    List<ChartData> generateChartDataList(
        List<String> timeList, List<double> temperatureList) {
      List<ChartData> chartDataList = [];
      for (int i = 0; i < timeList.length; i++) {
        final time = DateFormat('dd/MM').format(DateTime.parse(timeList[i]));
        chartDataList.add(
          ChartData(time, temperatureList[i]),
        );
      }
      return chartDataList;
    }

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
              city.name.toString(),
              style: customStyle(18, Colors.lightBlueAccent),
            ),
            Text('${city.admin1}, ${city.country}',
                style: customStyle(18, Colors.white)),
          ],
        ),
        SfCartesianChart(
          tooltipBehavior: _tooltipBehavior,
          title: ChartTitle(
              text: 'Weekly Forecast',
              textStyle: customStyle(13, Colors.white)),
          legend: Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              textStyle: customStyle(13, Colors.white)),
          series: <ChartSeries>[
            LineSeries<ChartData, String>(
              name: 'Min tempurature',
              dataSource:
                  generateChartDataList(weekly!.time, weekly.temperature_2mMin),
              xValueMapper: (ChartData data, _) => data.time,
              yValueMapper: (ChartData data, _) => data.tempurature,
              color: Colors.blue,
              markerSettings: const MarkerSettings(isVisible: true),
            ),
            LineSeries<ChartData, String>(
              name: 'Max tempurature',
              dataSource:
                  generateChartDataList(weekly.time, weekly.temperature_2mMax),
              xValueMapper: (ChartData data, _) => data.time,
              yValueMapper: (ChartData data, _) => data.tempurature,
              color: Colors.red,
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
              itemCount: weekly.time.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, index) {
                final time = DateFormat('dd/MM')
                    .format(DateTime.parse(weekly.time[index]));
                return Container(
                  width: 180,
                  margin: const EdgeInsets.all(5.0),
                  color: Colors.grey.withOpacity(0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        time,
                        style: customStyle(16, Colors.white),
                      ),
                      CustomLottie(code: weekly.weathercode[index]),
                      Column(
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: customStyle(15, Colors.red),
                                  text: '${weekly.temperature_2mMax[index]}°C',
                                  children: const [
                                TextSpan(
                                    text: ' max',
                                    style: TextStyle(fontSize: 12)),
                              ])),
                          RichText(
                              text: TextSpan(
                                  style: customStyle(15, Colors.blue),
                                  text: '${weekly.temperature_2mMin[index]}°C',
                                  children: const [
                                TextSpan(
                                    text: ' min',
                                    style: TextStyle(fontSize: 12)),
                              ])),
                        ],
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.time, this.tempurature);
  final String? time;
  final double? tempurature;
}
