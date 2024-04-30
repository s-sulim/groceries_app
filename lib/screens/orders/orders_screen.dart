import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:groceries_app/providers/orders_provider.dart';
import 'package:groceries_app/widgets/back_widget.dart';
import 'package:groceries_app/widgets/empty.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../../widgets/text_widget.dart';
import 'orders_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
   final ordersProvider = Provider.of<OrdersProvider>(context,listen: false);
   final ordersList = ordersProvider.getOrders;
    // Size size = Utils(context).getScreenSize;
   return FutureBuilder(
    future: ordersProvider.fetchOrders(),
    builder: (context, snapshot){
     return ordersList.isEmpty ? const EmptyScreen(
      title: 'No orders yet',
      subtitle: 'Try to order something',
      buttonText: 'Shop now',
      imagePath: 'assets/images/cart.png',
    // ignore: dead_code
    ) : Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          elevation: 0,
          centerTitle: false,
          title: TextWidget(
            text: 'Your orders (${ordersList.length})',
            color: color,
            textSize: 24.0,
            isTitle: true,
          ),
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        body: ListView.separated(
          itemCount: ordersList.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
              child: ChangeNotifierProvider.value(
                value: ordersList[index],
                child: const OrderWidget()),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: color,thickness: 1,
            );
          },
        ));
   });
  }
}
