class Cities {
  String name;
  String admin1;
  String country;
  double latitude;
  double longitude;
  CurrentWeather? currentWeather;

  Cities({
    this.name = '',
    this.admin1 = '',
    this.country = '',
    this.latitude = double.maxFinite,
    this.longitude = double.maxFinite,
    this.currentWeather,
  });

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      admin1: json['admin1'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }
}

class CurrentWeather {
  final Weather currentWeather;
  final Hourly hourly;
  final Daily daily;

  CurrentWeather({
    required this.currentWeather,
    required this.hourly,
    required this.daily,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      currentWeather: Weather.fromJson(json['current_weather']),
      hourly: Hourly.fromJson(json['hourly']),
      daily: Daily.fromJson(json['daily']),
    );
  }
}

class Weather {
  final double temperature;
  final double windspeed;
  final int weathercode;

  Weather({
    this.temperature = double.maxFinite,
    this.windspeed = double.maxFinite,
    this.weathercode = 0,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['temperature'],
      windspeed: json['windspeed'],
      weathercode: json['weathercode'],
    );
  }
}

class Hourly {
  final List<String> time;
  final List<double> temperature2m;
  final List<double> windspeed10m;
  final List<int> weathercode;

  Hourly({
    required this.time,
    required this.temperature2m,
    required this.windspeed10m,
    required this.weathercode,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      time: json['time'].cast<String>(),
      temperature2m: json['temperature_2m'].cast<double>(),
      windspeed10m: json['windspeed_10m'].cast<double>(),
      weathercode: json['weathercode'].cast<int>(),
    );
  }
}

class Daily {
  final List<String> time;
  final List<double> temperature_2mMax;
  final List<double> temperature_2mMin;
  final List<int> weathercode;

  Daily({
    required this.time,
    required this.temperature_2mMax,
    required this.temperature_2mMin,
    required this.weathercode,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
        time: json['time'].cast<String>(),
        temperature_2mMax: json['temperature_2m_max'].cast<double>(),
        temperature_2mMin: json['temperature_2m_min'].cast<double>(),
        weathercode: (json['weathercode'].cast<int>()));
  }
}
