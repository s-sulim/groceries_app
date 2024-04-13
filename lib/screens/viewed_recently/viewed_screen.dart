import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:groceries_app/providers/viewed_provider.dart';
import 'package:groceries_app/screens/viewed_recently/viewed_widget.dart';
import 'package:groceries_app/widgets/back_widget.dart';
import 'package:groceries_app/widgets/empty.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';


class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';

  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyScreenState createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
       final viewedProvider = Provider.of<ViewedProdProvider>(context);
   final viewedItemsList = viewedProvider.getViewedProdlistItems.values.toList().reversed.toList();
    // Size size = Utils(context).getScreenSize;
    return viewedItemsList.isEmpty ? const EmptyScreen(
      title: 'Your history is empty',
      subtitle: 'You should take a look at our products',
      buttonText: 'Shop now',
      imagePath: 'assets/images/history.png',
    // ignore: dead_code
    ) :  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              GlobalMethods.warningDialog(
                  title: 'Empty your history?',
                  subtitle: 'Are you sure?',
                  fct: () {},
                  context: context);
            },
            icon: Icon(
              IconlyBroken.delete,
              color: color,
            ),
          )
        ],
        leading: const  BackWidget(),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: TextWidget(
          text: 'History',
          color: color,
          textSize: 24.0,
        ),
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      ),
      body: ListView.builder(
          itemCount: viewedItemsList.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
              child: ChangeNotifierProvider.value(
                value: viewedItemsList[index],
                child: ViewedRecentlyWidget()),
            );
          }),
    );
  }
}
