import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:groceries_app/inner_screens/product_details.dart';
import 'package:groceries_app/models/wishlist_model.dart' as wm;
import 'package:groceries_app/providers/products_provider.dart' as pp;
import 'package:groceries_app/providers/wishlist_provider.dart' as wp;
import 'package:groceries_app/services/global_methods.dart';
import 'package:groceries_app/widgets/heart_btn.dart';
import 'package:groceries_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import '../../services/utils.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
      final productsProvider = Provider.of<pp.ProductsProvider>(context);
         final WishlistModel = Provider.of<wm.WishlistModel>(context);
      final currentProduct = productsProvider.findById(WishlistModel.productId);
        final wishlistProvider = Provider.of<wp.WishlistProvider>(context);
      bool? _isInWishlist = wishlistProvider.getWishlistItems.containsKey(currentProduct.id);
      final double realPrice = currentProduct.isOnSale ? currentProduct.salePrice : currentProduct.price;
    // final WishlistProvider = Provider.of<wp.WishlistProvider>(context);
 
// bool? _isInWishlist = WishlistProvider.getWishlistItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
             Navigator.pushNamed(context, ProductDetails.routeName, arguments: currentProduct.id);
        },
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Flexible(
                flex:2,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  // width: size.width * 0.2,
                  height: size.width * 0.25,
                  child: FancyShimmerImage(
                    imageUrl: currentProduct.imageUrl,
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconlyLight.bag2,
                              color: color,
                            ),
                          ),
                          HeartBTN(productId: currentProduct.id, isInwishlist: _isInWishlist)
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: TextWidget(
                        text: currentProduct.title,
                        color: color,
                        textSize: 20.0,
                        maxLines: 1,
                        isTitle: true,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: '\$${realPrice.toStringAsFixed(2)}',
                      color: color,
                      textSize: 18.0,
                      maxLines: 1,
                      isTitle: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
