import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceries_app/consts/firebase_consts.dart';
import 'package:groceries_app/widgets/text_widget.dart';
import 'package:uuid/uuid.dart';

class GlobalMethods {
 static  navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }
  static Future <void> warningDialog(
    {
      required String title, required String subtitle, required Function fct, required BuildContext context
    }
  ) async{
await showDialog(context: context, builder: (context){
                      return  AlertDialog(
                         title: Row(
                            children: <Widget>[
                              Image.asset('assets/images/warning.png', width: 20, height: 20,), // Your icon
                              const SizedBox(width: 10), // Provides space between the icon and the text
                              Expanded(child: Text(title)), // Your text
                            ],
                          ),
                        content: Text(subtitle),
                     actions: [
                      TextButton(onPressed: (){
                        if  (Navigator.canPop(context)){
                          Navigator.pop(context);
                        }
                      }, child: const Text('Cancel', style: TextStyle(color:Colors.red))),
                      TextButton(onPressed: (){
                        fct();
                         if  (Navigator.canPop(context)){
                          Navigator.pop(context);
                        }
                      }, child: const Text('OK', style: TextStyle(color:Colors.cyan),),)
                     ], );
                    });
}
   static Future<void> errorDialog({

    required String subtitle,
    
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text('Error'),
            ]),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Ok',
                  textSize: 18,
                ),
              ),
             
            ],
          );
        });
  }
static Future<void> addToCart(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Item has been added to your cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }
  static Future<void> addtoWishlist(
      {required String productId,
      required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final wishlistId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Item has been added to your wishlist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }
}
