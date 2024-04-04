import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
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
    final Color color = Utils(context).color;
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
 const SizedBox(
            height: 6,
          ),
          TextButton(
            onPressed: () {},
            child: TextWidget(
              text: 'View all',
              maxLines: 1,
              color: Colors.blue,
              textSize: 20,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              RotatedBox(
                quarterTurns: -1,
                child: Row(
                  children: [
                    TextWidget(
                      text: 'On sale'.toUpperCase(),
                      color: Colors.red,
                      textSize: 22,
                      isTitle: true,
                    ),
                    const SizedBox(width: 5,),
                    const Icon(
                      IconlyLight.discount,
                      color: Colors.red,
                    ),
                  ],
                
                ),
              ),
              const SizedBox(width: 8,),
            
              Flexible(
                child: SizedBox(
                  height: size.height * 0.24,
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return const OnSaleWidget();
                      }),
                ),
              ),
            ],
          ),
          const SizedBox(height:10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              TextWidget(
                text: 'Our products', 
                color: color, 
                textSize: 22,
                 isTitle: true,),
                 const Spacer(),
                TextButton(
              onPressed: () {},
              child: TextWidget(
                text: 'Browse all',
                maxLines: 1,
                color: Colors.blue,
                textSize: 20,
              ),
            ),
            ],),
          )
        ],
      ),
   
    );
  }
}