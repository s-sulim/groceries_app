import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreferences{
  static const THEME_KEY = "DARK_THEME_ENABLED";
  setDarkTheme(bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_KEY, value);
  }
  Future <bool> getTheme() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getBool(THEME_KEY) ?? false;
  }
}