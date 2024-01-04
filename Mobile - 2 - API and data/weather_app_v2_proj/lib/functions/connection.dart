import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/functions/api.dart';
import 'package:weather_app_v2_proj/models/city.dart';
import 'package:weather_app_v2_proj/provider/provider.dart';

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

String getNameOfWeatherCode(int code) {
  switch (code) {
    case 0:
      return 'Clear sky';
    case 1:
      return 'Mainly clear';
    case 2:
      return 'Partly cloudy';
    case 3:
      return 'Overcast';
    case 45:
      return 'Fog and depositing rime fog';
    case 48:
      return 'Fog and depositing rime fog';
    case 51:
      return 'Drizzle: Light intensity';
    case 53:
      return 'Drizzle: Moderate intensity';
    case 55:
      return 'Drizzle: Dense intensity';
    case 56:
      return 'Freezing Drizzle: Light intensity';
    case 57:
      return 'Freezing Drizzle: Dense intensity';
    case 61:
      return 'Rain: Slight intensity';
    case 63:
      return 'Rain: Moderate intensity';
    case 65:
      return 'Rain: Heavy intensity';
    case 66:
      return 'Freezing Rain: Light intensity';
    case 67:
      return 'Freezing Rain: Heavy intensity';
    case 71:
      return 'Snow fall: Slight intensity';
    case 73:
      return 'Snow fall: Moderate intensity';
    case 75:
      return 'Snow fall: Heavy intensity';
    case 77:
      return 'Snow grains';
    case 80:
      return 'Rain showers: Slight intensity';
    case 81:
      return 'Rain showers: Moderate intensity';
    case 82:
      return 'Rain showers: Violent intensity';
    case 85:
      return 'Snow showers: Slight intensity';
    case 86:
      return 'Snow showers: Heavy intensity';
    case 95:
      return 'Thunderstorm: Slight';
    case 96:
      return 'Thunderstorm with slight hail';
    case 99:
      return 'Thunderstorm with heavy hail';
    default:
      return 'Unknown';
  }
}
