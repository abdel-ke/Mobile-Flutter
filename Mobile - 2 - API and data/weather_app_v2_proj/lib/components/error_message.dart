import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
