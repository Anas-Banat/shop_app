import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/favorits_screen.dart';
import 'package:shop_app/modules/shop_app/products/products_screen.dart';
import 'package:shop_app/modules/shop_app/settings_screen/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState() );
  static ShopCubit get(context) => BlocProvider.of(context);
  
  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritsScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
}