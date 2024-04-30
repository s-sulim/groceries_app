import 'package:flutter/foundation.dart';
import 'package:groceries_app/services/dark_theme_prefs.dart';

class DarkThemeProvider with ChangeNotifier{
  DarkThemePreferences darkThemePrefs = DarkThemePreferences();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;
  
 set setDarkTheme (bool value){
  _darkTheme = value;
  darkThemePrefs.setDarkTheme(value);
  notifyListeners();
 }
}