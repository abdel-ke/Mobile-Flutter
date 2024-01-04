import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_final_proj/functions/api.dart';
import 'package:weather_final_proj/models/city.dart';
import 'package:weather_final_proj/provider/provider.dart';

Future<bool> _checkPermistion() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return (false);
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return (false);
  }
  return (true);
}

Future<Placemark> getAddressFromLatLong(Position position) async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  return placemarks[0];
}

Future<Cities> getCityFromLocation(permission) async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  Placemark place = await getAddressFromLatLong(position);
  Cities city = Cities(
      name: place.locality ?? '',
      admin1: place.administrativeArea ?? '',
      country: place.country ?? '',
      latitude: position.latitude,
      longitude: position.longitude);
  return city;
}

getLocationHelper() async {
  final permission = await _checkPermistion();
  if (permission == false) {
    return {"permission": permission};
  } else {
    final city = await getCityFromLocation(permission);
    final curr = await fetchWeatherData(city.latitude, city.longitude);
    return {"permission": permission, "city": city, "current": curr};
  }
}

getLocation(BuildContext context) async {
  final myProvider = context.read<MyProvider>();
  final check = await checkConnection();
  myProvider.isconnected = check;
  if (check == true) {
    getLocationHelper().then((value) {
      if (value['permission'] == true) {
        myProvider.permission = value['permission'];
        myProvider.city = value['city'];
        myProvider.city.currentWeather = value['current'];
      } else {
        myProvider.permission = value['permission'];
      }
    });
  }
}

Map<String, String> getNameOfWeatherCode(int code) {
  switch (code) {
      case 0:
        return {
          "name": "Clear sky",
          "icon": "assets/lotties/clearSky.json",
        };
      case 1:
        return {
          "name": "Mainly clear",
          "icon": "assets/lotties/clearSky.json",
        };
      case 2:
        return {
          "name": "partly cloudy",
          "icon": "assets/lotties/partlyCloudy.json",
        };
      case 3:
        return {
          "name": "overcast",
          "icon": "assets/lotties/partlyCloudy.json",
        };
      case 45:
        return {
          "name": "Fog",
          "icon": "assets/lotties/partlyCloudy.json",
        };
      case 48:
        return {
          "name": "depositing rime fog",
          "icon": "assets/lotties/partlyCloudy.json",
        };
      case 51:
        return {
          "name": "Light drizzle",
          "icon": "assets/lotties/partlyCloudy.json",
        };
      case 53:
        return {
          "name": "Moderate drizzle",
          "icon": "assets/lotties/partlyCloudy.json",
        };
      case 55:
        return {
          "name": "Dense intensity Drizzle",
          "icon": "assets/lotties/partlyCloudy.json",
        };
      case 56:
        return {
          "name": "Light freezing Drizzle",
          "icon": "assets/lotties/partlyCloudy.json",
        };
      case 57:
        return {
          "name": "Dense intensity freezing Drizzle",
          "icon": "assets/lotties/partlyCloudy.json",
        };
      case 61:
        return {
          "name": "Slight rain",
          "icon": "assets/lotties/slightRain.json",
        };
      case 63:
        return {
          "name": "Moderate rain",
          "icon": "assets/lotties/slightRain.json",
        };
      case 65:
        return {
          "name": "Heavy intensity rain",
          "icon": "assets/lotties/slightRain.json",
        };
      case 66:
        return {
          "name": "Light freezing rain",
          "icon": "assets/lotties/slightRain.json",
        };
      case 67:
        return {
          "name": "Heavy intensity freezing rain",
          "icon": "assets/lotties/slightRain.json",
        };
      case 71:
        return {
          "name": "Slight Snow fall",
          "icon": "assets/lotties/slightSnowFall.json",
        };
      case 73:
        return {
          "name": "moderate Snow fall",
          "icon": "assets/lotties/slightSnowFall.json",
        };
      case 75:
        return {
          "name": "heavy intensity Snow fall",
          "icon": "assets/lotties/slightSnowFall.json",
        };
      case 77:
        return {
          "name": "Snow grains",
          "icon": "assets/lotties/slightSnowFall.json",
        };
      case 80:
        return {
          "name": "Slight rain showers",
          "icon": "assets/lotties/slightSnowFall.json",
        };
      case 81:
        return {
          "name": "moderate rain showers",
          "icon": "assets/lotties/slightSnowFall.json",
        };
      case 82:
        return {
          "name": "violent rain showers",
          "icon": "assets/lotties/slightSnowFall.json",
        };
      case 85:
        return {
          "name": "slight snow showers",
          "icon": "assets/lotties/slightSnowFall.json",
        };
      case 86:
        return {
          "name": "heavy snow showers",
          "icon": "assets/lotties/slightSnowFall.json",
        };
      case 95:
        return {
          "name": "Thunderstorm",
          "icon": "assets/lotties/thunderstorm.json",
        };
      case 96:
        return {
          "name": "Thunderstorm with slight hail",
          "icon": "assets/lotties/thunderstorm.json",
        };
      case 99:
        return {
          "name": "CThunderstorm with heavy hail",
          "icon": "assets/lotties/thunderstorm.json",
        };
      default:
        return {
          "name": "Unkonw Weather",
          "icon": "assets/lotties/thunderstorm.json",
        };
    }
}
