import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:groceries_app/services/global_methods.dart';
import 'package:groceries_app/services/utils.dart';
import 'package:groceries_app/widgets/back_widget.dart';
import 'package:groceries_app/widgets/empty.dart';
import 'package:groceries_app/widgets/text_widget.dart';

import 'wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    bool _isEmpty = true;
    // ignore: unused_local_variable
    Size size = Utils(context).getScreenSize;
    return _isEmpty ? const EmptyScreen(
      title: 'Your wishlist is empty',
      subtitle: 'Check ou what we have for you',
      buttonText: 'Add a wish now',
      imagePath: 'assets/images/wishlist.png',
    // ignore: dead_code
    ): Scaffold(
        appBar: AppBar(centerTitle: true,
            leading: const BackWidget(),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: TextWidget(
              text: 'Wishlist (2)',
              color: color,
              isTitle: true,
              textSize: 22,
            ),
            actions: [
              IconButton(
                onPressed: () {
                   GlobalMethods.warningDialog(title: 'Empty your wishlist?', subtitle: 'U sure?', fct: (){}, context: context);
                },
                icon: Icon(
                  IconlyBroken.delete,
                  color: color,
                ),
              ),
            ]),
        body: MasonryGridView.count(
          crossAxisCount: 2,
          // mainAxisSpacing: 16,
          // crossAxisSpacing: 20,
          itemBuilder: (context, index) {
            return const WishlistWidget();
          },
        ));
  }
}
