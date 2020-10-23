import 'package:cloudtech_calculator/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                ),
              ],
            ),
          )),
    );
  }
}

class CursState extends StatefulWidget {
  @override
  _CursRouteState createState() => _CursRouteState();
}

class _CursRouteState extends State<CursState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NOTHING",
          style: GoogleFonts.rubik(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
            letterSpacing: 3.06,
          ),
          textAlign: TextAlign.center,
        ),
        shadowColor: const Color(0x00000000),
      ),
      body: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: ListTile(
                    leading: IconButton(
                        icon: Icon(
                          Icons.settings_display,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: null),
                    title: Text(
                      "USD",
                      style: GoogleFonts.rubik(
                          fontSize: 21,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).accentColor),
                    ),
                    trailing: Text(
                      "77,96 ₽",
                      style: GoogleFonts.rubik(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: ListTile(
                    leading: IconButton(
                        icon: Icon(
                          Icons.settings_display,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: null),
                    title: Text(
                      "USD",
                      style: GoogleFonts.rubik(
                          fontSize: 21,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).accentColor),
                    ),
                    trailing: Text(
                      "77,96 ₽",
                      style: GoogleFonts.rubik(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
