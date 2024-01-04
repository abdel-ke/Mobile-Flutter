import 'package:flutter/material.dart';
import 'package:weather_app_v2_proj/components/custom_app_bar.dart';
import 'package:weather_app_v2_proj/components/custom_bottom_navigation.dart';
import 'package:weather_app_v2_proj/components/custom_page_view.dart';
import 'package:weather_app_v2_proj/functions/connection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    getLocation(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: const CustomAppBar(),
          body: CustomPageView(pageViewController: _pageViewController),
          bottomNavigationBar: CustomBottomNavigationBar(
            pageViewController: _pageViewController,
          )),
    );
  }
}
