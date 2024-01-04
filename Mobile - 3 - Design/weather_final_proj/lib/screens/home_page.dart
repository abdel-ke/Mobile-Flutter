import 'package:flutter/material.dart';
import 'package:weather_final_proj/functions/connection.dart';
import 'package:weather_final_proj/components/bottom_navigation_bar.dart';
import 'package:weather_final_proj/components/custom_app_bar.dart';
import 'package:weather_final_proj/components/custom_page_view.dart';

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
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background/galaxy.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(),
          body: CustomPageView(pageViewController: _pageViewController),
          bottomNavigationBar: CustomBottomNavigationBar(
              pageViewController: _pageViewController)),
    );
  }
}
