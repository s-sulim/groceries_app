import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:groceries_app/consts/firebase_consts.dart';
import 'package:groceries_app/models/products_model.dart';
import 'package:groceries_app/providers/products_provider.dart' as pp;
import 'package:groceries_app/providers/wishlist_provider.dart';
import 'package:groceries_app/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartBTN extends StatefulWidget {
  const HeartBTN({Key? key, required this.productId, required this.isInwishlist}) : super(key: key);
  final String productId;
  final bool? isInwishlist;

  @override
  State<HeartBTN> createState() => _HeartBTNState();
}

class _HeartBTNState extends State<HeartBTN> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final ProductsProvider = Provider.of<pp.ProductsProvider>(context);
    final ProductModel currentProduct = ProductsProvider.findById(widget.productId);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () async {
        setState(() {
          loading = true;
        });

        try {
            final User? user = authInstance.currentUser;
        if (user == null){
          GlobalMethods.errorDialog(subtitle: 'To do this, you will have to login first!', context: context);
          return;
        }
        if (widget.isInwishlist == false && widget.isInwishlist != null){
          await  GlobalMethods.addtoWishlist(productId: widget.productId, context: context);
        }
        else {

            wishlistProvider.removeOneItem(wishlistId: wishlistProvider.getWishlistItems[currentProduct.id]!.id, productId: widget.productId);
        }
       await wishlistProvider.fetchWishlist();
        // wishlistProvider.addRemoveProduct(productId: productId)
        } catch (e) {
          GlobalMethods.errorDialog(subtitle: '$e', context: context);
        } finally {
          setState(() {
            loading = false;
          });
        }
      },
      child: loading ? const Padding(padding: EdgeInsets.all(8.0), child: SizedBox( height: 20, width:20, child:  CircularProgressIndicator())) : Icon(
        widget.isInwishlist != null && widget.isInwishlist == true ?  IconlyBold.heart : IconlyLight.heart,
        size: 22,
        color:  widget.isInwishlist != null && widget.isInwishlist == true ? Colors.red :  color,
      ),
    );
  }
}
