import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:groceries_app/consts/constss.dart';
import 'package:groceries_app/consts/firebase_consts.dart';
import 'package:groceries_app/providers/cart_provider.dart';
import 'package:groceries_app/providers/wishlist_provider.dart';
import 'package:groceries_app/screens/bottom_bar.dart';
import 'package:provider/provider.dart';

import 'providers/products_provider.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  List<String> images = Constss.authImagesPaths;
  @override
  void initState() {
    images.shuffle();
    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider =
          Provider.of<CartProvider>(context, listen: false);

              final wishlistProvider =
          Provider.of<WishlistProvider>(context, listen: false);

      await productsProvider.fetchProducts();
      
      cartProvider.clearLocalCart();
      wishlistProvider.clearLocalWishlist();
      if (authInstance.currentUser != null){
         await cartProvider.fetchCart();
         await wishlistProvider.fetchWishlist();
      }
    
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => const BottomBarScreen(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            images[0],
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
