import 'dart:js';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:groceries_app/inner_screens/product_details.dart';
import 'package:groceries_app/models/products_model.dart';
import 'package:groceries_app/services/global_methods.dart';
import 'package:groceries_app/services/utils.dart';
import 'package:groceries_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';


import 'price_widget.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
   final productModel = Provider.of<ProductModel>(context);
   
    // final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    return Material(
      color: Theme.of(context).cardColor.withOpacity(0.9),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName, arguments: productModel.id);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(imageUrl: productModel.imageUrl,
                     height: size.height * 0.12,
                     width: size.width * 0.22,
                      boxFit: BoxFit.fill,),
                    
                    Column(
                      children: [
                        TextWidget(
                          text: productModel.isPiece ? 'PC' : 'KG',
                          color: color,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                IconlyLight.bag2,
                                size: 22,
                                color: color,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print('print heart button is pressed');
                              },
                              child: Icon(
                                IconlyLight.heart,
                                size: 22,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                PriceWidget(
                      isOnSale: productModel.isOnSale,
                    price: productModel.price,
                    salePrice:productModel.salePrice,
                    textPrice: '1',
                ),
                const SizedBox(height: 5),
                TextWidget(text: productModel.title, color: color, textSize: 16, isTitle: true,),
                const SizedBox(height: 5),
              ]),
        ),
      ),
    );
  }
}
