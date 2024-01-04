import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_final_proj/provider/provider.dart';
import 'package:weather_final_proj/screens/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider())
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: HomePage()),
    );
  }
}
