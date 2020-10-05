import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloudtech_calculator/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'route.dart';

enum Operation {
  plus,
  minus,
  multi,
  div,
  point,
  res,
  percent,
  plusMinus,
  backspace,
  clear
}

extension OperationExtension on Operation {
  String getString() {
    switch (this) {
      case Operation.plus:
        return "+";
      case Operation.minus:
        return "-";
      case Operation.multi:
        return "x";
      case Operation.div:
        return "÷";
      case Operation.point:
        return ".";
      case Operation.res:
        return "=";
      default:
        throw UnimplementedError();
    }
  }
}

enum Numbers { zero, one, two, three, four, five, six, seven, eight, nine }

extension NumbersExtension on num {
  num backspace() {
    String pull = "$this";
    pull = pull.substring(0, pull.length - 1);
    if (pull.isNotEmpty && pull.split('').last.contains('.')) {
      pull = pull.substring(0, pull.length - 1);
    }
    return num.parse(pull, (pull) => 0);
  }

  num concat({bool pointer, int value}) {
    if (pointer == true) {
      final String pull = "${this}." + "$value";
      return num.parse(pull);
    } else {
      final String pull = "$this" + "$value";
      return num.parse(pull);
    }
  }
}

void main() => runApp(ChangeNotifierProvider<ThemeModel>(
    create: (BuildContext context) => ThemeModel(), child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeModel>(context).currentTheme,
      home: const MyHomePage(title: 'Калькулятор'),
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
  num a, b;
  bool pointStatus;
  dynamic operator;
  String textResh = "0";

  void getCalc(dynamic type) {
    if (type is Numbers) {
      if (a == null) {
        a = type.index;

        setState(() {
          textResh = '$a';
        });
      } else if (a != null && operator == null) {
        if (pointStatus == true) {
          a = a.concat(pointer: true, value: type.index);
          pointStatus = false;
        } else {
          a = a.concat(pointer: false, value: type.index);
        }

        setState(() {
          textResh = '$a';
        });
      } else if (operator != null) {
        if (b == null) {
          b = type.index;
          setState(() {
            textResh = "$a ${(operator as Operation).getString()} $b";
          });
        } else if (b != null) {
          if (pointStatus == true) {
            b = b.concat(pointer: true, value: type.index);
            pointStatus = false;
          } else {
            b = b.concat(pointer: false, value: type.index);
          }
          pointStatus = false;

          setState(() {
            textResh = "$a ${(operator as Operation).getString()} $b";
          });
        }
      }
    } else if (type is Operation) {
      if (type == Operation.res) {
        setState(() {
          textResh = "$a ${(operator as Operation).getString()} $b";
        });
        a = operationEvent(a, b, operator as Operation);
        b = null;
        operator = null;
        setState(() {
          textResh = "$a";
        });
      } else if (type == Operation.point) {
        if (a != null && b == null) {
          if (a is double) {
            pointStatus = false;
            setState(() {
              textResh = "$a";
            });
          } else {
            pointStatus = true;
            setState(() {
              textResh = "$a.";
            });
          }
        } else {
          if (b is double) {
            pointStatus = false;
            setState(() {
              textResh = "$a ${(operator as Operation).getString()} $b";
            });
          } else {
            pointStatus = true;
            setState(() {
              textResh = "$a ${(operator as Operation).getString()} $b.";
            });
          }
        }
      } else if (type == Operation.clear) {
        a = 0;
        b = null;
        operator = null;
        setState(() {
          textResh = "$a";
        });
      } else if (type == Operation.backspace) {
        if (a != null && b == null) {
          a = a.backspace();
          setState(() {
            textResh = "$a";
          });
        } else {
          b = b.backspace();
          setState(() {
            textResh = "$a ${(operator as Operation).getString()} $b";
          });
        }
      } else if (type == Operation.plusMinus) {
        if (a != null && b == null) {
          a = a * -1;
          setState(() {
            textResh = "$a";
          });
        } else {
          b = b * -1;
          setState(() {
            textResh = "$a ${(operator as Operation).getString()} $b";
          });
        }
      } else if (type == Operation.percent) {
        if (a != null && b == null) {
          a = a / 100;
          setState(() {
            textResh = "$a";
          });
        } else {
          b = b / 100;
          setState(() {
            textResh = "$a ${(operator as Operation).getString()} $b";
          });
        }
      } else {
        operator = type;
        setState(() {
          textResh = "$a ${(operator as Operation).getString()}";
        });
      }
    }
  }

  num operationEvent(num x, num y, Operation op) {
    num result = 0;
    switch (op) {
      case Operation.plus:
        result = x + y;
        break;
      case Operation.minus:
        result = x - y;
        break;
      case Operation.multi:
        result = x * y;
        break;
      case Operation.div:
        result = x / y;
        break;
      default:
        result = 0;
        break;
    }

    if (result % 1 == 0) {
      return result.toInt();
    } else {
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
              style: TextStyle(color: Theme.of(context).accentColor)),
          shadowColor: const Color(0x00000000),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Show Snackbar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
              color: Theme.of(context).accentColor,
            )
          ],
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: AutoSizeText(
                        textResh,
                        style: TextStyle(
                            fontSize: 70, color: Theme.of(context).accentColor),
                        maxLines: 1,
                      )),
                ),
                Row(
                  children: [
                    CallButton(
                      text: "±",
                      value: Operation.plusMinus,
                      onPressed: getCalc,
                    ),
                    CallButton(
                        text: "%",
                        value: Operation.percent,
                        onPressed: getCalc),
                    CallButton(
                        text: "⌫",
                        value: Operation.backspace,
                        onPressed: getCalc),
                    CallButton(
                        text: "AC", value: Operation.clear, onPressed: getCalc),
                  ],
                ),
                Row(
                  children: [
                    CallButton(
                      text: "7",
                      value: Numbers.seven,
                      onPressed: getCalc,
                    ),
                    CallButton(
                        text: "8", value: Numbers.eight, onPressed: getCalc),
                    CallButton(
                        text: "9", value: Numbers.nine, onPressed: getCalc),
                    CallButton(
                        text: "/", value: Operation.div, onPressed: getCalc),
                  ],
                ),
                Row(
                  children: [
                    CallButton(
                        text: "4", value: Numbers.four, onPressed: getCalc),
                    CallButton(
                        text: "5", value: Numbers.five, onPressed: getCalc),
                    CallButton(
                        text: "6", value: Numbers.six, onPressed: getCalc),
                    CallButton(
                        text: "*", value: Operation.multi, onPressed: getCalc),
                  ],
                ),
                Row(
                  children: [
                    CallButton(
                        text: "1", value: Numbers.one, onPressed: getCalc),
                    CallButton(
                        text: "2", value: Numbers.two, onPressed: getCalc),
                    CallButton(
                        text: "3", value: Numbers.three, onPressed: getCalc),
                    CallButton(
                        text: "-", value: Operation.minus, onPressed: getCalc),
                  ],
                ),
                Row(
                  children: [
                    CallButton(
                        text: "0", value: Numbers.zero, onPressed: getCalc),
                    CallButton(
                        text: ".", value: Operation.point, onPressed: getCalc),
                    CallButton(
                        text: "=", value: Operation.res, onPressed: getCalc),
                    CallButton(
                      text: "+",
                      value: Operation.plus,
                      onPressed: getCalc,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class CallButton extends StatelessWidget {
  final String text;
  final dynamic value;

  final void Function(dynamic) onPressed;

  const CallButton(
      {@required this.text, @required this.value, @required this.onPressed});

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
              color: const Color(0x00000000)),
          child: FlatButton(
            height: 60,
            onPressed: () => onPressed(value),
            child: Text(
              text,
              style:
                  TextStyle(fontSize: 30, color: Theme.of(context).accentColor),
            ),
          ),
        ),
      ),
    );
  }
}
