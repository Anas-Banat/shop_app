import 'dart:js';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state){
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null, 
          builder: (context) => producsBuilder(ShopCubit.get(context).homeModel),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      }, 
      listener: (context, state){},
    );
  }


  Widget producsBuilder(HomeModel model) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data.banners.map((e) => Image(
            image:NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
            ),
          ).toList(), 
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            // To let the image take full size in the screen
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),

        SizedBox(
          height: 10,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(
                height: 10,
              ),
        
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCategoryItem(), 
                  separatorBuilder: (context, index) => SizedBox(width: 10.0,), 
                  itemCount: 10,
                ),
              ),

              SizedBox(
                height: 10,
              ),
        
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 20,
        ),

        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            // its like padding 
            childAspectRatio: 1 / 1.58,
            children: List.generate(model.data.products.length, (index) => buildGridProduct(model.data.products[index]),
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildCategoryItem() => Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage('https://th.bing.com/th/id/OIP.Oyj2NutYcS0fRoqD0Niy9QHaE8?pid=ImgDet&rs=1'),
              height: 100.0,
              width: 100.0,
              fit: BoxFit.cover,
              ),

            Container(
              color: Colors.black.withOpacity(0.6),
              width: 100.0,
              child: Text(
                "Electronics",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                   color: Colors.white,
                ),
              ),
            ),
          ],
        );
  
  Widget buildGridProduct(ProductModel model) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image),
            width: double.infinity,
            height: 200.0,
            ),
            if(model.discount != 0)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 8.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.4,
                ),
              ),

              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),

                  SizedBox(
                    width: 5.0,
                  ),

                  if(model.discount != 0)
                    Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),

                  Spacer(),
                  
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){}, 
                    icon: Icon(Icons.favorite),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}