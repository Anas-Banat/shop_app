import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopCubitMode extends Cubit<ShopStates> {
  ShopCubitMode() : super(ShopInitialState());

  static ShopCubitMode get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool formShared}) {
    if (formShared != null) {
      isDark = formShared;
      emit(ShopChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ShopChangeModeState());
      });
    }
  }
}
