import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/models/products_model.dart' as pm;

class ProductsProvider with ChangeNotifier {
  static final List<pm.ProductModel> _productsList = [];
  List<pm.ProductModel> get getProducts {
    return _productsList;
  }

  List<pm.ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      productSnapshot.docs.forEach((element) {
        _productsList.insert(
            0,
            pm.ProductModel(
              id: element.get('id'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              productCategoryName: element.get('productCategoryName'),
              price: double.parse(
                element.get('price'),
              ),
              salePrice: element.get('salePrice'),
              isOnSale: element.get('isOnSale'),
              isPiece: element.get('isPiece'),
            ));
      });
    });
    notifyListeners();
  }

  pm.ProductModel findById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<pm.ProductModel> findByCategory(String categoryName) {
    List<pm.ProductModel> _categoryList = _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }
  List<pm.ProductModel> searchQuery(String searchText) {
    List<pm.ProductModel> _searchList = _productsList
        .where(
          (element) => element.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    return _searchList;
  }
}

//   // static final List<ProductModel> _productsList = [
//  ProductModel(
//       id: 'Apricot',
//       title: 'Apricot',
//       price: 0.99,
//       salePrice: 0.49,
//       imageUrl: 'https://static.vecteezy.com/system/resources/previews/029/228/635/non_2x/apricot-transparent-background-free-png.png',
//       productCategoryName: 'Фрукти',
//       isOnSale: true,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Avocado',
//       title: 'Avocado',
//       price: 0.88,
//       salePrice: 0.5,
//       imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/012/629/188/small/avocado-fruit-healthy-food-free-png.png',
//       productCategoryName: 'Фрукти',
//       isOnSale: false,
//       isPiece: true,
//     ),
//     ProductModel(
//       id: 'Black grapes',
//       title: 'Black grapes',
//       price: 1.22,
//       salePrice: 0.7,
//       imageUrl: 'https://static.vecteezy.com/system/resources/previews/019/984/212/non_2x/grape-fruit-transparent-png.png',
//       productCategoryName: 'Фрукти',
//       isOnSale: true,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Green grape',
//       title: 'Green grape',
//       price: 0.99,
//       salePrice: 0.4,
//       imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/012/629/192/small/grape-fruit-cutout-free-png.png',
//       productCategoryName: 'Фрукти',
//       isOnSale: false,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Red apple',
//       title: 'Red apple',
//       price: 0.6,
//       salePrice: 0.2,
//       imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/024/526/183/small/apple-isolated-red-apple-on-transparent-background-with-full-depth-of-field-apple-png.png',
//       productCategoryName: 'Фрукти',
//       isOnSale: true,
//       isPiece: false,
//     ),
//     // Vegi
//     ProductModel(
//       id: 'Carrots',
//       title: 'Carrots',
//       price: 0.99,
//       salePrice: 0.5,
//       imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/025/065/279/small/carrot-with-ai-generated-free-png.png',
//       productCategoryName: 'Овочі',
//       isOnSale: true,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Cauliflower',
//       title: 'Cauliflower',
//       price: 1.99,
//       salePrice: 0.99,
//       imageUrl: 'https://static.vecteezy.com/system/resources/previews/027/214/407/non_2x/cauliflower-cauliflower-transparent-background-ai-generated-free-png.png',
//       productCategoryName: 'Овочі',
//       isOnSale: false,
//       isPiece: true,
//     ),
//     ProductModel(
//       id: 'Cucumber',
//       title: 'Cucumber',
//       price: 0.99,
//       salePrice: 0.5,
//       imageUrl: 'https://static.vecteezy.com/system/resources/previews/029/721/416/non_2x/cucumber-transparent-background-png.png',
//       productCategoryName: 'Овочі',
//       isOnSale: false,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Jalapeno',
//       title: 'Jalapeno',
//       price: 1.99,
//       salePrice: 0.89,
//       imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/015/080/712/small/green-pepper-vegetables-food-transparent-png.png',
//       productCategoryName: 'Овочі',
//       isOnSale: false,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Long yam',
//       title: 'Long yam',
//       price: 2.99,
//       salePrice: 1.59,
//       imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBKMNMoSmUbZUI_QSmIHFIKk1PKvKLhX_X4dzvU8LqCA&s',
//       productCategoryName: 'Овочі',
//       isOnSale: false,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Onions',
//       title: 'Onions',
//       price: 0.59,
//       salePrice: 0.28,
//       imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn2I30gZj5cgi7QGs9P9yOmJlZLVxTkm2jVV0WG3vTiw&s',
//       productCategoryName: 'Овочі',
//       isOnSale: false,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Plantain-flower',
//       title: 'Plantain-flower',
//       price: 0.99,
//       salePrice: 0.389,
//       imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5hH0kQlwU3kMLsNb_-izDgepek8fOJZ2AUEpe6H5NhQ&s',
//       productCategoryName: 'Овочі',
//       isOnSale: false,
//       isPiece: true,
//     ),
//     ProductModel(
//       id: 'Potato',
//       title: 'Potato',
//       price: 0.99,
//       salePrice: 0.59,
//       imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpxVdZMW52U-zy6XNONcD906RR7cWDoE1yg2-NsdYSCw&s',
//       productCategoryName: 'Овочі',
//       isOnSale: true,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Radish',
//       title: 'Radish',
//       price: 0.99,
//       salePrice: 0.79,
//       imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO7jCASOHQZN6Z7RYpGJsyB1Grkq1DfCUWefp6Yat3Tw&s',
//       productCategoryName: 'Овочі',
//       isOnSale: false,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Red peppers',
//       title: 'Red peppers',
//       price: 0.99,
//       salePrice: 0.57,
//       imageUrl: 'https://static.vecteezy.com/system/resources/previews/017/207/164/original/red-hot-chili-pepper-isolated-on-png.png',
//       productCategoryName: 'Овочі',
//       isOnSale: false,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Squash',
//       title: 'Squash',
//       price: 3.99,
//       salePrice: 2.99,
//       imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_NiCYNEEHmzA8XrfmgjNvcxLs7BRwbrNdCguNPfrVUA&s',
//       productCategoryName: 'Овочі',
//       isOnSale: true,
//       isPiece: true,
//     ),
//     ProductModel(
//       id: 'Tomatoes',
//       title: 'Tomatoes',
//       price: 0.99,
//       salePrice: 0.39,
//       imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_xZldOQdU21rrLGWzx8pcQOgWm34InlfXtUNZ52KUUA&s',
//       productCategoryName: 'Овочі',
//       isOnSale: true,
//       isPiece: false,
//     ),
//     // Крупи
//     ProductModel(
//       id: 'Corn-cobs',
//       title: 'Corn-cobs',
//       price: 0.29,
//       salePrice: 0.19,
//       imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnE7lAzQKLg-4dEP6KeTaRpTbC_I19k2x410N3xTLdPA&s',
//       productCategoryName: 'Крупи',
//       isOnSale: false,
//       isPiece: true,
//     ),
//     ProductModel(
//       id: 'Peas',
//       title: 'Peas',
//       price: 0.99,
//       salePrice: 0.49,
//       imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/010/856/607/small/fresh-green-peas-or-sugar-snap-peas-isolated-on-white-background-png.png',
//       productCategoryName: 'Крупи',
//       isOnSale: false,
//       isPiece: false,
//     ),
//     // Трави
//     ProductModel(
//       id: 'Asparagus',
//       title: 'Asparagus',
//       price: 6.99,
//       salePrice: 4.99,
//       imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/010/985/477/small/vegetarian-fresh-green-asparagus-vegetable-cut-out-png.png',
//       productCategoryName: 'Трави',
//       isOnSale: false,
//       isPiece: false,
//     ),
//     ProductModel(
//       id: 'Brokoli',
//       title: 'Brokoli',
//       price: 0.99,
//       salePrice: 0.89,
//       imageUrl: 'https://static.vecteezy.com/system/resources/previews/027/216/070/non_2x/broccoli-broccoli-broccoli-transparent-background-ai-generated-free-png.png',
//       productCategoryName: 'Трави',
//       isOnSale: true,
//       isPiece: true,
//     ),
//     ProductModel(
//       id: 'Buk-choy',
//       title: 'Buk-choy',
//       price: 1.99,
//       salePrice: 0.99,
//       imageUrl: 'https://static.vecteezy.com/system/resources/previews/035/647/615/non_2x/ai-generated-bok-choy-isolated-on-transparent-background-free-png.png',
//       productCategoryName: 'Трави',
//       isOnSale: true,
//       isPiece: true,
//     ),
//     ProductModel(
//       id: 'Leek',
//       title: 'Leek',
//       price: 0.99,
//       salePrice: 0.5,
//       imageUrl: 'https://static.vecteezy.com/system/resources/previews/036/265/391/non_2x/ai-generated-green-and-white-leek-with-roots-isolated-transparent-background-png.png',
//       productCategoryName: 'Трави',
//       isOnSale: false,
//       isPiece: true,
//     ),
//     ProductModel(
//       id: 'Spinach',
//       title: 'Spinach',
//       price: 0.89,
//       salePrice: 0.59,
//       imageUrl: 'https://static.vecteezy.com/system/resources/previews/029/713/384/non_2x/spinach-transparent-background-png.png',
//       productCategoryName: 'Трави',
//       isOnSale: true,
//       isPiece: true,
//     ),
//     ProductModel(
//       id: 'Almond',
//       title: 'Almond',
//       price: 8.99,
//       salePrice: 6.5,
//       imageUrl: 'https://static.vecteezy.com/system/resources/previews/012/596/322/non_2x/almond-nut-with-leaves-free-png.png',
//       productCategoryName: 'Горіхи',
//       isOnSale: true,
//       isPiece: false,
//     ),
//   ];
// }