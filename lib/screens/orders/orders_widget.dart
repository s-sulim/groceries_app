import 'dart:js';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/inner_screens/product_details.dart';
import 'package:groceries_app/models/orders_model.dart';
import 'package:groceries_app/models/products_model.dart';
import 'package:groceries_app/providers/products_provider.dart' as pp;
import 'package:groceries_app/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateDisplay;

  @override
  void didChangeDependencies() {
   final orderModel = Provider.of<OrderModel>(this.context);
   var orderDate = orderModel.orderDate.toDate();
   orderDateDisplay = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
        final ProductsProvider = Provider.of<pp.ProductsProvider>(context);
    final ProductModel currentProduct = ProductsProvider.findById(orderModel.productId);

    return ListTile(
      subtitle: Text('Paid: \$${double.parse(orderModel.price).toStringAsFixed(2)}'),
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      leading:  FancyShimmerImage(
          width: size.width * 0.2,
          imageUrl: orderModel.imageUrl,
          boxFit: BoxFit.fill,
        ),
      
      title: TextWidget(text: '${currentProduct.title}  x${orderModel.quantity}', color: color, textSize: 18),
      trailing: TextWidget(text: orderDateDisplay, color: color, textSize: 18),
    );
  }
}
