import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/favorits_screen.dart';
import 'package:shop_app/modules/shop_app/products/products_screen.dart';
import 'package:shop_app/modules/shop_app/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';

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

  HomeModel homeModel;
  Map<int, bool> favorites = {};

  void getHomeData(){
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: HOME, 
        token: token,
        query: null
      ).then((value){
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.data.banners.toString());
      print(homeModel.status);
      print(homeModel.data.banners[0].image);

      // Map to add favorate items
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error){
       print(error.toString());
       emit(ShopErrorHomeDataState());
    });
  }


  CategoriesModel categoriesModel;
  void getCategories(){
    DioHelper.getData(
        url: GET_CATEGOTIES, 
        token: token,
      ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
       print(error.toString());
       emit(ShopErrorCategoriesState());
    });
  }


  ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId){
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'productId': productId,
      },
      token: token
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error){
      emit(ShopErrorChangeFavoritesState());
    });
  }
}