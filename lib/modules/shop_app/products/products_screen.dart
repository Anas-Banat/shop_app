import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/home_model.dart';

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


  Widget producsBuilder(HomeModel model) => Column(
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
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ),
    ],
  );
}