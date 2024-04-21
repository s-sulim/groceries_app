import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:groceries_app/widgets/text_widget.dart';

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
              const Text('An Error occured'),
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
}
