import 'package:flutter/material.dart';
import 'package:groceries_app/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    
    return Scaffold(
      body: Center(child: 
      SwitchListTile(
        title: Text('Theme', style:   TextStyle(color: themeState.getDarkTheme ? Colors.white38 : Colors.black38)),
        secondary: Icon(themeState.getDarkTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
        onChanged: (bool value){
            setState(() {
              themeState.setDarkTheme = value;
            });
        },
        value: themeState.getDarkTheme
      ))
    );
  }
}