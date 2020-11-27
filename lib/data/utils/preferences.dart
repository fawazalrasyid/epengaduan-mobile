import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences settings;
  
  static Future getInstance() async {
    settings = await SharedPreferences.getInstance();
  }
}