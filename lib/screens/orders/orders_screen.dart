import 'package:flutter/material.dart';
import 'package:groceries_app/widgets/back_widget.dart';
import 'package:groceries_app/widgets/empty.dart';

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
    bool _isEmpty = true;
    // Size size = Utils(context).getScreenSize;
    return _isEmpty ? const EmptyScreen(
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
            text: 'Your orders (2)',
            color: color,
            textSize: 24.0,
            isTitle: true,
          ),
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        body: ListView.separated(
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
              child: OrderWidget(),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: color,thickness: 1,
            );
          },
        ));
  }
}
