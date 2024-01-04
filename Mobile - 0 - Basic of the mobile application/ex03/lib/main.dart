import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String input = "0";
  String result = "0";

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
          title: const Text('Calculator'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    customText(screenSize, input),
                    customText(screenSize, result),
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
      ),
    );
  }

  Widget customGrid(screenSize) {
    final double itemHeight = (screenSize.height - kToolbarHeight - 24) / 2;
    final double itemWidth = screenSize.width / 1.25;
    return Container(
      width: screenSize.width,
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
        handleButtons(val);
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
          style: const TextStyle(fontSize: 20,),
        ),
      ),
    );
  }

  Widget customText(screenSize, display) {
    return Container(
      width: screenSize.width,
      height: screenSize.height / 6,
      alignment: Alignment.bottomRight,
      child: Text(
        display,
        style: const TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
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
  }

  handleButtons(val) {
    if (input == "0") {
      setState(() {
        input = "";
      });
    }
    if (val == 'AC') {
      setState(() {
        input = '0';
        result = "0";
      });
    } else if (val == 'C') {
      if (input.isNotEmpty) {
        setState(() {
          input = input.substring(0, input.length - 1);
        });
      }
    } else if (val == '=') {
      calculate();
    } else {
      setState(() {
        input += val;
      });
    }
    // ignore: avoid_print
    print(input);
  }

  calculate() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(input);
      ContextModel cm = ContextModel();
      setState(() {
        result = exp.evaluate(EvaluationType.REAL, cm).toString();
      });
    } catch (e) {
      setState(() {
        result = "0";
      }); // Handle error cases
    }
  }
}
