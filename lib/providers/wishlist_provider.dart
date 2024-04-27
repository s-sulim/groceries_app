import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:groceries_app/consts/firebase_consts.dart';
import 'package:groceries_app/models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier{

Map<String, WishlistModel> _wishlistItems = {};

Map <String, WishlistModel> get getWishlistItems{
  return _wishlistItems;
}

// void addRemoveProduct({required String productId}){
//   if  (_wishlistItems.containsKey(productId)){
//     removeFromWishlist(productId);
//   }
//   else  {
//     _wishlistItems.putIfAbsent(productId, () => WishlistModel(id: DateTime.now().toString(), productId: productId));
//   }
//     notifyListeners();
// }
Future<void> fetchWishlist() async {
      final User? user = authInstance.currentUser;
      final userCollection = FirebaseFirestore.instance.collection('users');
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
  
    if (userDoc == null) {
      return;
    }
    final leng = userDoc.get('userWish').length;
    for (int i = 0; i < leng; i++) {
      _wishlistItems.putIfAbsent(
          userDoc.get('userWish')[i]['productId'],
          () => WishlistModel(
                id: userDoc.get('userWish')[i]['wishlistId'],
                productId: userDoc.get('userWish')[i]['productId'],
              ));
    }
    notifyListeners();
  }


  Future<void> removeOneItem(
    
      {required String wishlistId,
      required String productId}) async {
          final User? user = authInstance.currentUser;
      final userCollection = FirebaseFirestore.instance.collection('users');
    await userCollection.doc(user!.uid).update({
      'userWish': FieldValue.arrayRemove([
        {'wishlistId': wishlistId, 'productId': productId}
      ])
    });
    _wishlistItems.remove(productId);
    await fetchWishlist();
    notifyListeners();
  }

 Future<void> clearOnlineWishlist() async {
      final User? user = authInstance.currentUser;
      final userCollection = FirebaseFirestore.instance.collection('users');
    await userCollection.doc(user!.uid).update({
      'userwish': [],
    });
    _wishlistItems.clear();
    notifyListeners();
  }
void clearLocalWishlist(){
  _wishlistItems.clear();
  notifyListeners();
}
}