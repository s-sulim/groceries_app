import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:groceries_app/providers/dark_theme_provider.dart';
import 'package:groceries_app/providers/cart_provider.dart';
import 'package:groceries_app/screens/cart/cart_screen.dart';
import 'package:groceries_app/screens/categories.dart';
import 'package:groceries_app/screens/home_screen.dart';
import 'package:groceries_app/screens/user.dart';
import 'package:groceries_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badge;


class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {

int _selectedIndex = 0;

 final List <Map<String, dynamic>> _pages = [
  {'page': const HomeScreen(), 'title': 'Home'},
  {'page': CategoriesScreen(), 'title': 'Categories'},
  {'page': const CartScreen(), 'title': 'Cart'},
  {'page': const UserScreen(), 'title': 'My profile'}
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
        final themeState = Provider.of<DarkThemeProvider>(context);
        bool _isDark = themeState.getDarkTheme;
        final cartProvider = Provider.of<CartProvider>(context);
        final cartItemsList = cartProvider.getCartItems.values.toList().reversed.toList();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_pages[_selectedIndex]['title']),
      // ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
        unselectedItemColor: _isDark ? Colors.white38 : Colors.black38,
           selectedItemColor: _isDark ? Colors.lightBlue.shade200 : Colors.black38,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _selectedPage,
        items:  
      <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 0 ? IconlyBold.home :   IconlyLight.home), 
          label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 1 ? IconlyBold.category : IconlyLight.category),
          label: 'Categories'),
           BottomNavigationBarItem(
               label: 'Cart',
          icon: cartItemsList.isEmpty ?  Icon( _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy) : badge.Badge(
            badgeAnimation: const badge.BadgeAnimation.slide(),
            badgeStyle: badge.BadgeStyle(
              shape: badge.BadgeShape.circle,
              badgeColor: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            position: badge.BadgePosition.topEnd(top: -7, end: -7),
            badgeContent: FittedBox(
                child: TextWidget(
                    text: cartItemsList.length.toString(),
                    color: Colors.white,
                    textSize: 15)),
            child: Icon(
                _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),)),
                      
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
            label: "User", )]),
         
          );
  }
}