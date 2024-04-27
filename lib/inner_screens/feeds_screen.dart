import 'package:flutter/material.dart';
import 'package:groceries_app/consts/constss.dart';
import 'package:groceries_app/models/products_model.dart';
import 'package:groceries_app/providers/products_provider.dart' as pp;
import 'package:groceries_app/widgets/back_widget.dart';
import 'package:groceries_app/widgets/empty_products_widget.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';
import '../widgets/feed_items.dart';
import '../widgets/text_widget.dart';
import 'dart:ui_web' as ui_web;

class FeedsScreen extends StatefulWidget {
  static const routeName = "/FeedsScreenState";
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
    List<ProductModel> listProductSearch =[];
  final FocusNode _searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }
  //   @override
  // void initState() {
  //     final prodProv = Provider.of<pp.ProductsProvider>(context, listen: false);
  //     prodProv.fetchProducts();

  //     super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final ProductsProvider = Provider.of<pp.ProductsProvider>(context);
    List<ProductModel> allProducts = ProductsProvider.getProducts;
    return Scaffold(
      appBar: AppBar(
        leading: BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: 'All Products',
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                focusNode: _searchTextFocusNode,
                controller: _searchTextController,
                onChanged: (valuee) {
             setState(() {
                          listProductSearch = ProductsProvider.searchQuery(valuee);
                        });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.greenAccent, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.greenAccent, width: 1),
                  ),
                  hintText: "What's in your mind",
                  prefixIcon: const Icon(Icons.search),
                  suffix: IconButton(
                    onPressed: () {
                      _searchTextController!.clear();
                      _searchTextFocusNode.unfocus();
                    },
                    icon: Icon(
                      Icons.close,
                      color: _searchTextFocusNode.hasFocus ? Colors.red : color,
                    ),
                  ),
                ),
              ),
            ),
          ),
            _searchTextController!.text.isNotEmpty && listProductSearch.isEmpty  ? 
             const EmptyProdWidget(text: 'No products found') : GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.zero,
                  // crossAxisSpacing: 10,
                  childAspectRatio: size.width / (size.height * 0.59),
                  children: List.generate(
                    
                       _searchTextController!.text.isNotEmpty ? listProductSearch.length :
                    allProducts.length, (index) {
                    return ChangeNotifierProvider.value(
                      value:     _searchTextController!.text.isNotEmpty ? listProductSearch[index]  :allProducts[index],
                      child: const FeedsWidget(),
                    );
                  }),
                ),
        ]),
      ),
    );
  }
}
