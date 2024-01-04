import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_final_proj/provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.pageViewController});

  final PageController pageViewController;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.yellowAccent,
      unselectedItemColor: Colors.white,
      currentIndex: context.watch<MyProvider>().activePage,
      onTap: (index) {
        pageViewController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceOut);
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: 'Currently'),
        BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Today'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), label: 'Weekly'),
      ],
    );
  }
}
