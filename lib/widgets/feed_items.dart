import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:groceries_app/inner_screens/product_details.dart';
import 'package:groceries_app/models/products_model.dart';
import 'package:groceries_app/providers/cart_provider.dart' as cp;
import 'package:groceries_app/services/global_methods.dart';
import 'package:groceries_app/widgets/price_widget.dart';
import 'package:groceries_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';
import 'heart_btn.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);
  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();

    
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final CartProvider = Provider.of<cp.CartProvider>(context);

    bool? _isInCart = CartProvider.getCartItems.containsKey(productModel.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName, arguments: productModel.id);
              // GlobalMethods.navigateTo(ctx: context, routeName: ProductDetails.routeName);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(children: [
            FancyShimmerImage(
              imageUrl: productModel.imageUrl,
              height: size.width * 0.21,
              width: size.width * 0.2,
              boxFit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex:3,
                    child: TextWidget(
                      text: productModel.title,
                      color: color,
                      maxLines: 1,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                  Flexible(flex:1, child: const HeartBTN()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4,
                    child: PriceWidget(
                      isOnSale: productModel.isOnSale,
                      price: productModel.price,
                      salePrice:productModel.salePrice,
                      textPrice: _quantityTextController.text,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Flexible(
                    flex: 3,
                    child: Row(
                      children: [
                        FittedBox(
                          child: TextWidget(
                            text: productModel.isPiece ? "PC" : "KG",
                            color: color,
                            textSize: 18,
                            isTitle: true,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          flex:4,
                            child: TextFormField(
                          controller: _quantityTextController,
                          key: const ValueKey('10'),
                          style: TextStyle(color: color, fontSize: 18),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          enabled: true,
                          onChanged: (value){
                            setState(() {
                            if (value.isEmpty) {
                              _quantityTextController.text = '1';
                            } 
                          });
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[0-9.]'),
                            ),
                          ],
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  if  (_isInCart){
                    return;
                  }
                  CartProvider.addToCart(productId: productModel.id, quantity: int.parse(_quantityTextController.text));
                },
                child: TextWidget(
                  text: _isInCart ? 'In cart' : 'Add to cart',
                  maxLines: 1,
                  color: color,
                  textSize: 20,
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).cardColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    )),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
