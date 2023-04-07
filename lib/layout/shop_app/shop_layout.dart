import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  get items => null;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: Text('Salla'),
        ),
        body: cubit.bottomScreens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            cubit.changeBottom(index);
          },
          currentIndex: cubit.currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home',
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps,),
              label: 'Categories',
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite,),
              label: 'Favorites',
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,),
              label: 'Settings',
              ),
            ]
          ),
        );
      }, 
    );
  }
}