

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:groceries_app/inner_screens/product_details.dart';
import 'package:groceries_app/models/viewed_model.dart';
import 'package:groceries_app/providers/cart_provider.dart';
import 'package:groceries_app/providers/products_provider.dart';
import 'package:groceries_app/services/global_methods.dart';
import 'package:provider/provider.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyWidgetState createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;

    final prodProv = Provider.of<ProductsProvider>(context);
    final viewedRecentlyModel = Provider.of<ViewedProdModel>(context);
    final currentProduct = prodProv.findById(viewedRecentlyModel.productId);
    final double realPrice = currentProduct.isOnSale ? currentProduct.salePrice : currentProduct.price;
    final cartProv = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProv.getCartItems.containsKey(currentProduct.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  GestureDetector(
          onTap: () {
            GlobalMethods.navigateTo(
                ctx: context, routeName: ProductDetails.routeName);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FancyShimmerImage(
                imageUrl: currentProduct.imageUrl,
                boxFit: BoxFit.fill,
                height: size.width * 0.27,
                width: size.width * 0.25,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                children: [
                  TextWidget(
                    text: currentProduct.title,
                    color: color,
                    textSize: 24,
                    isTitle: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextWidget(
                    text: '\$${realPrice.toStringAsFixed(2)}',
                    color: color,
                    textSize: 20,
                    isTitle: false,
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                     onTap: () {
                                    cartProv.addToCart(productId: currentProduct.id, quantity: 1);
                              },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                         _isInCart ? Icons.check : IconlyBold.plus,
                          color: Colors.white,
                          size: 20,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}
