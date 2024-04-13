import 'package:flutter/cupertino.dart';
import 'package:groceries_app/models/cart_model.dart';

class CartProvider with ChangeNotifier{

Map<String, CartModel> _cartItems = {};

Map <String, CartModel> get getCartItems{
  return _cartItems;
}


void addToCart(
  {
    required String productId,
    required int quantity,
  }
){
_cartItems.putIfAbsent(productId, () => CartModel(id: DateTime.now().toString(), productId: productId, quantity: quantity));
notifyListeners();
}
void decrementQuantity(String productId){
  _cartItems.update(productId, (value)=>CartModel(id:value.id, productId: productId, quantity: value.quantity-1));
notifyListeners();
}
void incrementQuantity(String productId){
  _cartItems.update(productId, (value)=>CartModel(id:value.id, productId: productId, quantity: value.quantity+1));
notifyListeners();
}
void removeFromCart(String productId){
  _cartItems.remove(productId);
  notifyListeners();
}
void clear(){
  _cartItems.clear();
  notifyListeners();
}
}