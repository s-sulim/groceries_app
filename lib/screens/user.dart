import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:groceries_app/provider/dark_theme_provider.dart';
import 'package:groceries_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController = TextEditingController();

  @override
  void dispose() {
   _addressTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

     final themeState = Provider.of<DarkThemeProvider>(context);
    final Color themeColor = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(text: TextSpan(
                  text: 'Здоров, ',
                   style: const TextStyle(color: Colors.cyan, fontSize: 27, fontWeight: FontWeight.bold), 
                   recognizer: TapGestureRecognizer()..onTap = (){print('User name pressed');},
                children:  <TextSpan>[
                   TextSpan(text: "як ся маєш??", style: TextStyle(color: themeColor, fontSize: 27, fontWeight: FontWeight.w600)),
                ]
                )
                ),
                   const SizedBox(height: 5),
                TextWidget(color: themeColor, text: 'test@gmail.com', textSize: 18, isTitle: false),
                const SizedBox(height: 20),
                const Divider(thickness: 2),
                const SizedBox(height: 20),
                _addListTile(title: 'Address', subtitle: 'My account', icon:IconlyLight.profile, color: themeColor, onPressed: () async{
                  await _showEditUserDataDialog();
                }),

                _addListTile(title: 'Orders', icon:IconlyLight.wallet,color: themeColor, onPressed: (){}),

                _addListTile(title: 'Wishlist', icon:IconlyLight.heart,color: themeColor, onPressed: (){}),

                _addListTile(title: 'Viewed', icon:IconlyLight.discovery,color: themeColor, onPressed: (){}),

                _addListTile(title: 'Forgot my password', icon:IconlyLight.unlock,color: themeColor, onPressed: (){}),
            
                SwitchListTile(
                   title: TextWidget(color: themeColor, text: 'Theme', textSize: 22, isTitle: true,),
            
                  // title: Text('Theme', style:   TextStyle(fontSize: 24, fontWeight:FontWeight.bold ,color: themeState.getDarkTheme ? Colors.white38 : Colors.black38)),
                  secondary: Icon(themeState.getDarkTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined, color: themeColor),
                  onChanged: (bool value){
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                    },
                value: themeState.getDarkTheme
                ),
            
                _addListTile(title: 'Logout', icon:IconlyLight.logout, color: themeColor, onPressed: ()async{
                  await _showLogoutDialog();
                })
                 
              ],
            ),
          ),
        ),
      )
    );
  }
Future <void> _showEditUserDataDialog() async{
await showDialog(context: context, builder: (context){
                      return  AlertDialog(
                        title: const Text('Update your data'),
                        content: TextField(
                          onChanged: (value){
                            // print('_addressTextController.text ${_addressTextController.text}');
                          },
                          controller: _addressTextController,
                          maxLines: 1,
                          decoration: const InputDecoration(hintText: "Your address"),),
                     
                     actions: [
                      TextButton(onPressed: (){}, child: const Text('Submit'),)
                     ], );
                    });
}
Future <void> _showLogoutDialog() async{
await showDialog(context: context, builder: (context){
                      return  AlertDialog(
                         title: Row(
                            children: <Widget>[
                              Image.asset('assets/images/logout.png', width: 20, height: 20,), // Your icon
                              const SizedBox(width: 10), // Provides space between the icon and the text
                              const Expanded(child: Text('Logout?')), // Your text
                            ],
                          ),
                        content: const Text('Are you sure you want to logout?'),
                     actions: [
                      TextButton(onPressed: (){
                        if  (Navigator.canPop(context)){
                          Navigator.pop(context);
                        }
                      }, child: const Text('No', style: TextStyle(color:Colors.red))),
                      TextButton(onPressed: (){}, child: const Text('Yes', style: TextStyle(color:Colors.cyan),),)
                     ], );
                    });
}

  Widget _addListTile({required String title, String? subtitle, required IconData icon, required Color color, required Function onPressed}){
  if  (subtitle != null){
    return ListTile(
            title: TextWidget(color: color, text: title, textSize: 22, isTitle: true,),
            subtitle: TextWidget(color: color,
              text: subtitle, textSize: 18,),
            leading: Icon(icon, color:color),
            trailing: Icon(IconlyLight.arrowRight2, color: color),
            onTap: (){
              onPressed();
            }
          );
  }
  else{
    return ListTile(
            title: TextWidget(color: color, text: title, textSize: 22, isTitle: true,),
            leading: Icon(icon, color:color),
            trailing: Icon(IconlyLight.arrowRight2, color: color),
            onTap: (){
              onPressed();
            }
          );
     }
  }
}