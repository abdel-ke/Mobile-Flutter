import 'package:flutter/material.dart';
import 'package:weather_final_proj/functions/connection.dart';
import 'package:lottie/lottie.dart';

class CustomLottie extends StatelessWidget {
  const CustomLottie({super.key, required this.code});
  final int code;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      height: 90,
      getNameOfWeatherCode(code)['icon'].toString(),
      fit: BoxFit.contain,
    );
  }
}
