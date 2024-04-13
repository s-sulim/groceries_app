import 'package:flutter/material.dart';
import 'package:groceries_app/consts/theme_data.dart';
import 'package:groceries_app/inner_screens/cat_screen.dart';
import 'package:groceries_app/inner_screens/feeds_screen.dart';
import 'package:groceries_app/inner_screens/on_sale_screen.dart';
import 'package:groceries_app/inner_screens/product_details.dart';
import 'package:groceries_app/provider/dark_theme_provider.dart';
import 'package:groceries_app/providers/cart_provider.dart';
import 'package:groceries_app/providers/products_provider.dart';
import 'package:groceries_app/providers/wishlist_provider.dart';
import 'package:groceries_app/screens/auth/forgot_password_screen.dart';
import 'package:groceries_app/screens/auth/login_screen.dart';
import 'package:groceries_app/screens/auth/register_screen.dart';
import 'package:groceries_app/screens/bottom_bar.dart';
import 'package:groceries_app/screens/orders/orders_screen.dart';
import 'package:groceries_app/screens/viewed_recently/viewed_screen.dart';
import 'package:groceries_app/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
         ChangeNotifierProvider(create: (_) =>
           ProductsProvider(),
        ),
          ChangeNotifierProvider(create: (_) =>
           CartProvider(),
        ),
        ChangeNotifierProvider(create: (_) =>
           WishlistProvider(),
        )
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home:  const BottomBarScreen(),
            routes: {
                OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
                FeedsScreen.routeName: (ctx) => const FeedsScreen(),
                ProductDetails.routeName: (ctx) => const ProductDetails(),
                WishlistScreen.routeName: (ctx) => const WishlistScreen(),
                OrdersScreen.routeName: (ctx) => const OrdersScreen(),
                ViewedRecentlyScreen.routeName: (ctx) => const ViewedRecentlyScreen(),
                RegisterScreen.routeName: (ctx) => const RegisterScreen(),
                LoginScreen.routeName: (ctx) => const LoginScreen(),
                ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
                CategoryScreen.routeName: (ctx) => const CategoryScreen(),
            });
      }),
    );
  }
}