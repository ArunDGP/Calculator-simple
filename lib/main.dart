import 'package:flutter/material.dart';
import 'Widgets/buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'Widgets/picture.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  bool numbers(String x) {
    if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade300,
      body: SafeArea(
        child: Column(
          children: [
            Text('Let\'s Calculate what\'s in your mind!',
              style: GoogleFonts.lobster( textStyle: TextStyle(
                  color:Colors.black, fontSize: 20, fontWeight: FontWeight.w900,
              wordSpacing: 6)),),
            Padding(
              padding: const EdgeInsets.only(left: 11, right: 11),
              child: Divider(thickness: 1, color: Colors.black87,),
            ),
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 18),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11, right: 11),
                      child: Text(userQuestion, style: TextStyle(
                          fontSize: 34, fontWeight:FontWeight.bold, color:Colors.grey.shade800)),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11, right: 11),
                      child: Text(userAnswer,
                        style: TextStyle(fontSize: 34, fontWeight:FontWeight.bold, color:Colors.grey.shade800),
                      ),
                    ),
                  )
                ],
              ),
            )),
            Expanded(
              flex: 2,
              child: Container(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (context, i) {
                        if (i == 0) {
                          return MyButton(
                            Colors.green,
                            Colors.white,
                            buttons[i],
                            () {
                              setState(() {
                                userQuestion = '';
                                userAnswer = '0';
                              });
                            },
                          );
                        } else if (i == 1) {
                          return MyButton(
                            Colors.red,
                            Colors.white,
                            buttons[i],
                            () {
                              setState(() {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              });
                            },
                          );
                        } else if (buttons[i] == 'ANS') {
                          return Picture();
                        } else if (i == buttons.length - 1) {
                          return MyButton(
                            Colors.deepPurple,
                            Colors.white,
                            buttons[i],
                            () {
                              setState(() {
                                equalPressed();
                              });
                            },
                          );
                        } else {
                          return MyButton(
                            numbers(buttons[i])
                                ? Colors.deepPurple
                                : Colors.deepPurple[50],
                            numbers(buttons[i])
                                ? Colors.white
                                : Colors.deepPurple,
                            buttons[i],
                            () {
                              setState(() {
                                userQuestion += buttons[i];
                              });
                            },
                          );
                        }
                      })),
            )
          ],
        ),
      ),
    );
  }
}
