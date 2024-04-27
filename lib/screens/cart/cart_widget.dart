import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groceries_app/inner_screens/product_details.dart';
import 'package:groceries_app/models/cart_model.dart' as cm;
import 'package:groceries_app/models/products_model.dart' ;
import 'package:groceries_app/providers/cart_provider.dart';
import 'package:groceries_app/providers/products_provider.dart' as pp;
import 'package:groceries_app/providers/wishlist_provider.dart' as wp;
import 'package:groceries_app/services/global_methods.dart';
import 'package:groceries_app/services/utils.dart';
import 'package:groceries_app/widgets/heart_btn.dart';
import 'package:groceries_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key, required this.quantity}) : super(key: key);

  final int quantity;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = this.widget.quantity.toString();
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
final cartProvider = Provider.of<CartProvider>(context);
final ProductsProvider = Provider.of<pp.ProductsProvider>(context);
final CartModel = Provider.of<cm.CartModel>(context);
final currentProduct = ProductsProvider.findById(CartModel.productId);
final WishlistProvider = Provider.of<wp.WishlistProvider>(context);
bool? _isInWishlist = WishlistProvider.getWishlistItems.containsKey(currentProduct.id);


      final double realPrice = currentProduct.isOnSale ? currentProduct.salePrice : currentProduct.price;
    final double totalPrice = realPrice * int.parse(_quantityTextController.text);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName, arguments: currentProduct.id);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      height: size.width * 0.25,
                      width: size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: FancyShimmerImage(
                        imageUrl:currentProduct.imageUrl,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: currentProduct.title,
                          color: color,
                          textSize: 20,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Row(
                            children: [
                              _quantityController(
                                fct: () {
                                   setState(() {
                                   int currVal = int.parse(_quantityTextController.text);
                                   if (currVal > 1){
                                    _quantityTextController.text = (currVal - 1).toString();
                                      cartProvider.decrementQuantity(CartModel.productId);
                                   }
                                    
                                  });
                                },
                                color: Colors.red,
                                icon: CupertinoIcons.minus,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    setState(() {
                                      if (v.isEmpty) {
                                        _quantityTextController.text = '1';
                                      } else {
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),
                              _quantityController(
                                fct: () {
                                     cartProvider.incrementQuantity(CartModel.productId);
                                  setState(() {
                                 
                                    _quantityTextController.text = (int.parse(_quantityTextController.text) + 1).toString();
                                  });
                                },
                                color: Colors.green,
                                icon: CupertinoIcons.plus,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                            await  cartProvider.removeOneItem(cartId: CartModel.id, productId: CartModel.productId, quantity: CartModel.quantity);
                            },
                            child: const Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                         HeartBTN(productId: currentProduct.id, isInwishlist: _isInWishlist),
                          TextWidget(
                            text: '\$${(realPrice*int.parse(_quantityTextController.text)).toStringAsFixed(2)}',
                            color: color,
                            textSize: 18,
                            maxLines: 1,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
