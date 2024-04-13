import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:groceries_app/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({Key? key, required this.productId, required this.isInwishlist}) : super(key: key);
  final String productId;
  final bool? isInwishlist;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {
        wishlistProvider.addRemoveProduct(productId: productId);
      },
      child: Icon(
        isInwishlist != null && isInwishlist == true ?  IconlyBold.heart : IconlyLight.heart,
        size: 22,
        color:  isInwishlist != null && isInwishlist == true ? Colors.red :  color,
      ),
    );
  }
}
