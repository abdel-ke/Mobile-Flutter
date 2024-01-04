import 'package:flutter/material.dart';
import 'package:weather_app_v2_proj/functions/styles.dart';

class MyText extends StatelessWidget {
  const MyText({super.key, required String value, required double fontSize})
      : _value = value,
        _fontSize = fontSize;

  final String _value;
  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(_value, style: customStyle(_fontSize));
  }
}
