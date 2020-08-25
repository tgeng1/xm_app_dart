import 'package:flutter/material.dart';
import 'package:xm_app_dart/routes/login/Login.dart';
// import 'package:xm_app_dart/routes/home/home.dart';
import 'package:xm_app_dart/utils/global.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class _AppState extends State<App> {
  Widget startPage() {
    if (Global.token == null) {
      return Login();
    } else {
      // return Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to XM APP',
      home: new Container(
        child: startPage(),
      ),
      navigatorKey: navigatorKey,
    );
  }
}
