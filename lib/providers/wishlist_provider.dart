import 'package:flutter/cupertino.dart';
import 'package:groceries_app/models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier{

Map<String, WishlistModel> _wishlistItems = {};

Map <String, WishlistModel> get getWishlistItems{
  return _wishlistItems;
}

void addRemoveProduct({required String productId}){
  if  (_wishlistItems.containsKey(productId)){
    removeFromWishlist(productId);
  }
  else  {
    _wishlistItems.putIfAbsent(productId, () => WishlistModel(id: DateTime.now().toString(), productId: productId));
  }
    notifyListeners();
}

void removeFromWishlist(String productId){
  _wishlistItems.remove(productId);
  notifyListeners();
}
void clearWishlist(){
  _wishlistItems.clear();
  notifyListeners();
}
}