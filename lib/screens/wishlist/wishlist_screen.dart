import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:groceries_app/providers/wishlist_provider.dart';
import 'package:groceries_app/services/global_methods.dart';
import 'package:groceries_app/services/utils.dart';
import 'package:groceries_app/widgets/back_widget.dart';
import 'package:groceries_app/widgets/empty.dart';
import 'package:groceries_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import 'wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
      final wishlistProvider = Provider.of<WishlistProvider>(context);
   final wishlistItemsList = wishlistProvider.getWishlistItems.values.toList().reversed.toList();

    // ignore: unused_local_variable
    Size size = Utils(context).getScreenSize;
    return wishlistItemsList.isEmpty ? const EmptyScreen(
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
              text: 'Wishlist (${wishlistItemsList.length})',
              color: color,
              isTitle: true,
              textSize: 22,
            ),
            actions: [
              IconButton(
                onPressed: () {
                   GlobalMethods.warningDialog(title: 'Empty your wishlist?', subtitle: 'U sure?', fct: () async{
                    await wishlistProvider.clearOnlineWishlist();
                    wishlistProvider.clearLocalWishlist();
                   }, context: context);
                },
                icon: Icon(
                  IconlyBroken.delete,
                  color: color,
                ),
              ),
            ]),
        body: MasonryGridView.count(
          itemCount: wishlistItemsList.length,
          crossAxisCount: 2,
          // mainAxisSpacing: 16,
          // crossAxisSpacing: 20,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
              value: wishlistItemsList[index],
              child: const WishlistWidget());
          },
        ));
  }
}
