import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloudtech_calculator/extension.dart';
import 'package:cloudtech_calculator/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/getcalc_bloc.dart';
import 'route.dart';

void main() => runApp(ChangeNotifierProvider<ThemeModel>(
    create: (BuildContext context) => ThemeModel(), child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeModel>(context).currentTheme,
      home: MyHomePage(title: 'Калькулятор'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final _getCalc = CalcEventBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title,
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
                    child: BlocBuilder<CalcEventBloc, CalcEventState>(
                        cubit: _getCalc,
                        builder: (context, state) {
                          if (state is EmptyState) {
                            return AutoSizeText(
                              "0",
                              style: TextStyle(
                                  fontSize: 70,
                                  color: Theme.of(context).accentColor),
                              maxLines: 1,
                            );
                          } else if (state is FirstState) {
                            return AutoSizeText(
                              state.a.toString(),
                              style: TextStyle(
                                  fontSize: 70,
                                  color: Theme.of(context).accentColor),
                              maxLines: 1,
                            );
                          } else if (state is OperatorState &&
                              state.b == null) {
                            return AutoSizeText(
                              "${state.a}${state.operator.getString()}",
                              style: TextStyle(
                                  fontSize: 70,
                                  color: Theme.of(context).accentColor),
                              maxLines: 1,
                            );
                          } else if (state is OperatorState &&
                              state.b != null) {
                            return AutoSizeText(
                              "${state.a}${state.operator.getString()}${state.b}.",
                              style: TextStyle(
                                  fontSize: 70,
                                  color: Theme.of(context).accentColor),
                              maxLines: 1,
                            );
                          } else if (state is SecondState) {
                            return AutoSizeText(
                              "${state.a}${state.operator.getString()}${state.b}",
                              style: TextStyle(
                                  fontSize: 70,
                                  color: Theme.of(context).accentColor),
                              maxLines: 1,
                            );
                          } else if (state is ResultState) {
                            return AutoSizeText(
                              "${state.result}",
                              style: TextStyle(
                                  fontSize: 70,
                                  color: Theme.of(context).accentColor),
                              maxLines: 1,
                            );
                          }

                          return const SizedBox.shrink();
                        }),
                  ),
                ),
                Row(
                  children: [
                    CallButton(
                        text: "±",
                        onPressed: () =>
                            _getCalc.add(PlusMinusOperationEvent())),
                    CallButton(
                        text: "%",
                        onPressed: () => _getCalc.add(PercentOperationEvent())),
                    CallButton(
                        text: "⌫",
                        onPressed: () =>
                            _getCalc.add(BackspaceOperationEvent())),
                    CallButton(
                        text: "AC",
                        onPressed: () =>
                            _getCalc.add(ClearAllOperationEvent())),
                  ],
                ),
                Row(
                  children: [
                    CallButton(
                        text: "7",
                        onPressed: () => _getCalc.add(NumberEvent(7))),
                    CallButton(
                        text: "8",
                        onPressed: () => _getCalc.add(NumberEvent(8))),
                    CallButton(
                        text: "9",
                        onPressed: () => _getCalc.add(NumberEvent(9))),
                    CallButton(
                        text: "/",
                        onPressed: () =>
                            _getCalc.add(DivisionOperationEvent())),
                  ],
                ),
                Row(
                  children: [
                    CallButton(
                        text: "4",
                        onPressed: () => _getCalc.add(NumberEvent(4))),
                    CallButton(
                        text: "5",
                        onPressed: () => _getCalc.add(NumberEvent(5))),
                    CallButton(
                        text: "6",
                        onPressed: () => _getCalc.add(NumberEvent(6))),
                    CallButton(
                        text: "*",
                        onPressed: () => _getCalc.add(MultiOperationEvent())),
                  ],
                ),
                Row(
                  children: [
                    CallButton(
                        text: "1",
                        onPressed: () => _getCalc.add(NumberEvent(1))),
                    CallButton(
                        text: "2",
                        onPressed: () => _getCalc.add(NumberEvent(2))),
                    CallButton(
                        text: "3",
                        onPressed: () => _getCalc.add(NumberEvent(3))),
                    CallButton(
                        text: "-",
                        onPressed: () => _getCalc.add(MinusOperationEvent())),
                  ],
                ),
                Row(
                  children: [
                    CallButton(
                        text: "0",
                        onPressed: () => _getCalc.add(NumberEvent(0))),
                    CallButton(
                        text: ".",
                        onPressed: () => _getCalc.add(PointOperationEvent())),
                    CallButton(
                        text: "=",
                        onPressed: () => _getCalc.add(ResultOperationEvent())),
                    CallButton(
                        text: "+",
                        onPressed: () => _getCalc.add(PlusOperationEvent())),
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
  final void Function() onPressed;
  const CallButton({@required this.text, @required this.onPressed});

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
            onPressed: () => onPressed(),
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
