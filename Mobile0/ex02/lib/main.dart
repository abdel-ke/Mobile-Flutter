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
  final btns = [
    '7',
    '8',
    '9',
    'C',
    'AC',
    '4',
    '5',
    '6',
    '+',
    '-',
    '1',
    '2',
    '3',
    '*',
    '/',
    '0',
    '.',
    '00',
    '%',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Calculator'),
          elevation: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  customText(screenSize),
                  customText(screenSize),
                ],
              )),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 232, 245, 248),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: customGrid(screenSize))),
            ],
          ),
        ),
      ),
    );
  }

  Widget customGrid(screenSize) {
    final double itemHeight = (screenSize.height - kToolbarHeight - 24) / 2;
    final double itemWidth = screenSize.width / 1.25;
    return Container(
      height: 110 * 4,
      alignment: Alignment.bottomCenter,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (itemWidth / itemHeight), crossAxisCount: 5),
        itemCount: btns.length,
        itemBuilder: (context, index) => customButton(btns[index]),
      ),
    );
  }

  Widget customButton(val) {
    return GestureDetector(
      onTap: () {
        print(val);
      },
      child: Container(
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: colorButtons(val),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          val,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget customText(screenSize) {
    return Container(
      width: screenSize.width,
      height: screenSize.height / 6,
      alignment: Alignment.bottomRight,
      child: const Text(
        "0",
        style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color colorButtons(val) {
    if (val == 'C') return const Color.fromARGB(255, 253, 228, 135);
    if (val == 'AC') return const Color.fromARGB(255, 245, 155, 185);
    if (val == '*' ||
        val == '-' ||
        val == '/' ||
        val == "%" ||
        val == '=' ||
        val == '+')
      // ignore: curly_braces_in_flow_control_structures
      return const Color.fromARGB(255, 182, 250, 244);
    return const Color.fromARGB(255, 255, 255, 255);
    // return const Color.fromARGB(255, 14, 192, 236);
  }
}
