import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _searchText = "";
  final TextEditingController _controller = TextEditingController();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final _pageViewController = PageController();
  int _activePage = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: TextField(
                onSubmitted: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
                controller: _controller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          actions: [
            const VerticalDivider(
              color: Colors.black,
              thickness: 0.8,
              endIndent: 10,
              indent: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      _searchText = "Geolocation";
                    });
                  },
                  icon: const Icon(Icons.location_on_outlined)),
            ),
          ],
        ),
        body: PageView(
          controller: _pageViewController,
          children: <Widget>[
            Center(
                child: Text(
              'Currently\n$_searchText',
              style: optionStyle,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )),
            Center(
                child: Text(
              'Today\n$_searchText',
              style: optionStyle,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )),
            Center(
                child: Text(
              'Weekly\n$_searchText',
              style: optionStyle,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )),
          ],
          onPageChanged: (index) {
            setState(() {
              _activePage = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _activePage,
          onTap: (index) {
            _pageViewController.animateToPage(index,
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
        ),
      ),
    );
  }
}
