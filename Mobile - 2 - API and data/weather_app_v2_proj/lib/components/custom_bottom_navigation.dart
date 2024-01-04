import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.pageViewController});
  final PageController pageViewController;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          currentIndex: context.watch<MyProvider>().activePage,
          onTap: (index) {
            pageViewController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn);
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