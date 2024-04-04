import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:groceries_app/services/utils.dart';
import 'package:groceries_app/widgets/on_sale_widget.dart';
import 'package:groceries_app/widgets/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> _offerImages = [
    'assets/images/offers/Offer1.jpg',
    'assets/images/offers/Offer2.jpg',
    'assets/images/offers/Offer3.jpg',
    'assets/images/offers/Offer4.jpg'
  ];

  @override
  Widget build(BuildContext context) {

    Size size = Utils(context).getScreenSize;
    return Scaffold(

      body: Column(
        children: [SizedBox(
          height: size.height * 0.33,
          child: Swiper(
          itemBuilder: (BuildContext context,int index){
            return Image.asset(_offerImages[index],fit: BoxFit.fill,);
          },
          autoplay: true,
          itemCount: _offerImages.length,
          pagination: const SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(color:Colors.white, activeColor: Colors.red)
          ),
        ),
            ),
           const SizedBox(height:6),
            TextButton(onPressed: (){}, child:TextWidget(text: 'View all', maxLines: 1, color: Colors.blue, textSize: 20,)),
           SizedBox(
            height: size.height * 0.24,
             child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index){
              return OnSaleWidget();
             },),
           )
        ]
      ),
   
    );
  }
}