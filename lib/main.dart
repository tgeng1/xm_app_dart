import 'package:flutter/material.dart';
import 'package:xm_app_dart/app.dart';
import 'package:xm_app_dart/utils/global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) => runApp(new App()));
}
