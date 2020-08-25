import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtil {
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static Future<String> getInfo(String keyName) async {
    final SharedPreferences _pref = await prefs;
    return _pref.getString(keyName);
  }

  static Future<List<String>> getListInfo(String keyName) async {
    final SharedPreferences _pref = await prefs;
    return _pref.getStringList(keyName);
  }

  static Future<bool> saveInfo(String keyName, String value) async {
    final SharedPreferences _pref = await prefs;
    return _pref.setString(keyName, value);
  }

  static Future<bool> saveList(String keyName, List<String> value) async {
    final SharedPreferences _pref = await prefs;
    return _pref.setStringList(keyName, value);
  }

  static Future<bool> removeInfo(String keyName) async {
    final SharedPreferences _pref = await prefs;
    return _pref.remove(keyName);
  }

  static localPath() async {
    var tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    return tempPath;
  }

  static localFile(path) async {
    return new File('$path/xmConfig.json');
  }

  // read json
  static Future<Map<String, dynamic>> readJson() async {
    final file = await localFile(await localPath());
    String str = await file.readAsString();
    Map<String, dynamic> map = json.decode(str);
    return map;
  }

  // write json
  static Future writeJson(map) async {
    final file = await localFile(await localPath());
    return file.writeAsString(jsonEncode(map));
  }
}
