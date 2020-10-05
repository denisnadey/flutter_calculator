import 'package:cloudtech_calculator/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Настройки калькулятора",
            style: TextStyle(color: Theme.of(context).accentColor)),
        shadowColor: const Color(0x00000000),
      ),
      body: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                ListTile(
                  leading: IconButton(
                      icon: Icon(
                        Icons.settings_display,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: null),
                  title: Text(
                    "Светлая тема",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).accentColor),
                  ),
                  trailing: Switch(
                    value: Theme.of(context).brightness == Brightness.light,
                    onChanged: (value) {
                      Provider.of<ThemeModel>(context, listen: false)
                          .toggleTheme();
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
