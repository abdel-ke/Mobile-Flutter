import 'package:flutter/material.dart';
import 'package:weather_app_v2_proj/models/city.dart';

class MyProvider extends ChangeNotifier {
  int _activePage = 0;
  bool _permission = true;
  Cities _city = Cities();
  bool _isconnected = true;

  int get activePage => _activePage;
  bool get permission => _permission;
  Cities get city => _city;
  bool get isconnected => _isconnected;
  set isconnected(bool value) {
    _isconnected = value;
    notifyListeners();
  }

  set activePage(int value) {
    _activePage = value;
    notifyListeners();
  }

  set permission(bool value) {
    _permission = value;
    notifyListeners();
  }

  set city(Cities value) {
    _city = value;
    notifyListeners();
  }
}
