import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:groceries_app/providers/cart_provider.dart';
import 'package:groceries_app/providers/cart_provider.dart' as cp;
import 'package:groceries_app/providers/products_provider.dart';
import 'package:groceries_app/screens/cart/cart_widget.dart';
import 'package:groceries_app/widgets/empty.dart';
import 'package:groceries_app/services/global_methods.dart';
import 'package:groceries_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import '../../services/utils.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    // Size size = Utils(context).getScreenSize;
   final cartProvider = Provider.of<cp.CartProvider>(context);
   final cartItemsList = cartProvider.getCartItems.values.toList().reversed.toList();
    return cartItemsList.isEmpty ? const EmptyScreen(
      title: 'Your cart is empty',
      subtitle: 'Maybe add  some stuff in here',
      buttonText: 'Shop now',
      imagePath: 'assets/images/cart.png',
    // ignore: dead_code
    ) : Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: 'Cart (${cartItemsList.length})',
            color: color,
            isTitle: true,
            textSize: 22,
          ),
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethods.warningDialog(title: 'Empty your cart?', subtitle: 'U sure?', fct: () async{
                  await cartProvider.clearOnlineCart();
                  cartProvider.clearLocalCart();
                }, context: context);
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            ),
          ]),
      body: Column(
        children: [
          _checkout(ctx: context),
          Expanded(
            child: ListView.builder(
              itemCount: cartItemsList.length,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: cartItemsList[index],
                  child: CartWidget(quantity: cartItemsList[index].quantity));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkout({required BuildContext ctx}) {
    final Color color = Utils(ctx).color;
    Size size = Utils(ctx).getScreenSize;
   final cartProvider = Provider.of<cp.CartProvider>(ctx);
   final productProvider = Provider.of<ProductsProvider>(ctx);
   double total = 0.0;
   cartProvider.getCartItems.forEach((key, value){
      var currentProduct = productProvider.findById(value.productId);
      total += (currentProduct.isOnSale ? currentProduct.salePrice : currentProduct.price) * value.quantity;
   });
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      // color: ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(children: [
          Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: 'Order Now',
                  textSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Spacer(),
          FittedBox(child: TextWidget(text: 'Total: \$${total.toStringAsFixed(2)}', color: color, textSize: 18, isTitle: true,))
        ]),
      ),
    );
  }
}
