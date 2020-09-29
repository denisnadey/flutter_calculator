import 'package:flutter/material.dart';

enum Operation { plus, minus, multi, div, point, res }
enum Numbers { zero, one, two, three, four, five, six, seven, eight, nine }
double a, b;
dynamic operator;

String textResh = "0";

void getCalc(dynamic type) {
  if (type is Numbers) {
    if (a == null) {
      a = type.index.toDouble();
      print("a: ${a}");
    } else if (a != null && operator == null) {
      if (a >= 0) {
        a = (a * 10) + type.index;
        print("a: ${a} - concat");
      }
    } else if (operator != null) {
      if (b == null) {
        b = type.index.toDouble();
        print("b: ${b}");
      } else if (b != null) {
        if (b >= 0) {
          b = (b * 10) + type.index;
          print("b: ${b} - concat");
        }
      }
    }
  }

  if (type is Operation) {
    if (type == Operation.res) {
      print("счиатаем выполняя : ${operator}");
      a = operationEvent(a.toInt(), b.toInt(), operator);
      b = null;

      print("ответ : ${a}");
    } else {
      operator = type;
    }
    print(type);
  }
}

double operationEvent(int x, int y, dynamic op) {
  double result = 0;
  switch (op) {
    case (Operation.plus):
      result = (x + y).toDouble();
      break;
    case (Operation.minus):
      result = (x - y).toDouble();
      break;
    case (Operation.multi):
      result = (x * y).toDouble();
      break;
    case (Operation.div):
      result = (x / y).toDouble();
      break;
    default:
      result = 0;
      break;
  }
  return result;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          color: const Color(0xFF4b44cf),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$textResh',
                      style: TextStyle(fontSize: 80, color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  children: [
                    CallButton(text: "7", value: Numbers.seven),
                    CallButton(text: "8", value: Numbers.eight),
                    CallButton(text: "9", value: Numbers.nine),
                    CallButton(text: "/", value: Operation.div),
                  ],
                ),
                Row(
                  children: [
                    CallButton(text: "4", value: Numbers.four),
                    CallButton(text: "5", value: Numbers.five),
                    CallButton(text: "6", value: Numbers.six),
                    CallButton(text: "*", value: Operation.multi),
                  ],
                ),
                Row(
                  children: [
                    CallButton(text: "1", value: Numbers.one),
                    CallButton(text: "2", value: Numbers.two),
                    CallButton(text: "3", value: Numbers.three),
                    CallButton(text: "-", value: Operation.minus),
                  ],
                ),
                Row(
                  children: [
                    CallButton(text: "0", value: Numbers.zero),
                    CallButton(text: ".", value: Operation.point),
                    CallButton(text: "=", value: Operation.res),
                    CallButton(text: "+", value: Operation.plus),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class CallButton extends StatelessWidget {
  String text;
  dynamic value;
  CallButton({this.text, this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xE0E0E0E0)),
          child: AspectRatio(
            aspectRatio: 1,
            child: FlatButton(
              onPressed: () {
                getCalc(value);
              },
              child: Text(
                text,
                style: TextStyle(fontSize: 60, color: Colors.blue[900]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
