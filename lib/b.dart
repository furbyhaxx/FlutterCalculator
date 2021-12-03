// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:calculator/button.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

double _font_size = 25.0;

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

//ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

  var _input_controller = TextEditingController();


  List<Button> buttons = [
    Button('C', Button.actionBtnColor, Button.actionTxtColor),
    Button('+/-', Button.actionBtnColor, Button.actionTxtColor),
    Button('%', Button.actionBtnColor, Button.actionTxtColor),
    Button('/', Button.operatorBtnColor, Button.operatorTxtColor),
    Button('7', Button.numberBtnColor, Button.numberTxtColor),
    Button('8', Button.numberBtnColor, Button.numberTxtColor),
    Button('9', Button.numberBtnColor, Button.numberTxtColor),
    Button('x', Button.operatorBtnColor, Button.operatorTxtColor),
    Button('4', Button.numberBtnColor, Button.numberTxtColor),
    Button('5', Button.numberBtnColor, Button.numberTxtColor),
    Button('6', Button.numberBtnColor, Button.numberTxtColor),
    Button('-', Button.operatorBtnColor, Button.operatorTxtColor),
    Button('1', Button.numberBtnColor, Button.numberTxtColor),
    Button('2', Button.numberBtnColor, Button.numberTxtColor),
    Button('3', Button.numberBtnColor, Button.numberTxtColor),
    Button('+', Button.operatorBtnColor, Button.operatorTxtColor),
    Button('0', Button.numberBtnColor, Button.numberTxtColor),
    Button('.', Button.numberBtnColor, Button.numberTxtColor),
    Button('DEL', Button.numberBtnColor, Button.numberTxtColor),
    Button('=', Button.calculateBtnColor, Button.calculateTxtColor),
  ];

  void btnCallback(Button btn) {
    switch (btn.text) {
      case "C":
        {
          setState(() {
            userInput = '';
            answer = '0';
          });
        }
        break;
      case "+/-":
        {
          setState(() {
            print("not implemented");
          });
        }
        break;
      case "%":
        {
          setState(() {
            userInput += btn.text;
          });
        }
        break;
      case "DEL":
        {
          setState(() {
            userInput = userInput.substring(0, userInput.length - 1);
          });
        }
        break;
      case "=":
        {
          setState(() {
            String finaluserinput = userInput;
            finaluserinput = userInput.replaceAll('x', '*');

            Parser p = Parser();
            Expression exp = p.parse(finaluserinput);
            ContextModel cm = ContextModel();
            double eval = exp.evaluate(EvaluationType.REAL, cm);
            answer = eval.toString();
          });
        }
        break;
      default:
        {
          _input_controller.value = _input_controller.value.copyWith(
            text: _input_controller.text + btn.text,
            selection: TextSelection.collapsed(
              offset: _input_controller.value.selection.baseOffset + btn.text.length,
            ),
          );
          // setState(() {
          //   userInput += btn.text;
          // });

        }
        break;
    }
  }

  List<Container> _buildGridTileList(int count) => List.generate(
      count,
      (i) => Container(
            // child: TextButton(
            //   style: TextButton.styleFrom(
            //     textStyle: TextStyle(fontSize: 18, color: buttons[i].textColor),
            //     backgroundColor: buttons[i].buttonColor,
            //   ),
            //   onPressed: () {
            //   btnCallback(buttons[i]);
            // },
            // child: Text(buttons[i].text),
            child: RawMaterialButton(
              fillColor: buttons[i].buttonColor,
              shape: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
              onPressed: () {
                btnCallback(buttons[i]);
              },
              child: Text(buttons[i].text, style: TextStyle(fontSize: _font_size, color: buttons[i].textColor)),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(flex: 1, child: Text("Text1")),
        Expanded(flex: 1, child: Text("Text1")),
        Container(
          child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              shrinkWrap: true,
              children: List.generate(
                  20,
                  (i) => Container(
                        child: TextButton(
                          onPressed: () {
                            print(i);
                          },
                          child: Text(i.toString()),
                        ),
                      ))),
        )
      ],
    ));
  }
}
