import 'package:flutter/material.dart';
import 'package:groceries_app/consts/theme_data.dart';
import 'package:groceries_app/provider/dark_theme_provider.dart';
import 'package:groceries_app/screens/bottom_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

DarkThemeProvider themeChangeProvider = DarkThemeProvider();

void getCurrentAppTheme() async{
  themeChangeProvider.setDarkTheme = await themeChangeProvider.darkThemePrefs.getTheme();
}
 @override
 void initState(){
  getCurrentAppTheme();
  super.initState();
 }
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_){
        return themeChangeProvider;
      })],
    child:Consumer<DarkThemeProvider>(
      builder: (context,themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: BottomBarScreen()
        );
      }
    )
    );
  }
}