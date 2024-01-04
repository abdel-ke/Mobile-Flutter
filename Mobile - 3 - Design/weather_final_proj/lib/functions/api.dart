import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:weather_final_proj/models/city.dart';

Future<bool> checkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }
  return true;
}

Future<CurrentWeather> fetchWeatherData(
    double latitude, double longitude) async {
  final response = await http.get(
    Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,weathercode,windspeed_10m&daily=weathercode,temperature_2m_max,temperature_2m_min&current_weather=true&timezone=GMT',
    ),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load weather data');
  }

  final jsonBody = json.decode(response.body);
  return CurrentWeather.fromJson(jsonBody);
}

Future fettchData(query) async {
  final connection = await checkConnection();
  if (connection == false) {
    return false;
  }
  final String url =
      'https://geocoding-api.open-meteo.com/v1/search?name=$query&count=5&language=en&format=json';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    if (json.containsKey('results')) {
      return json['results'];
    }
  }
  return null;
}
