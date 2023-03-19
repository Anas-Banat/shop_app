import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  
  void userLogin({
    String email,
    String password,
  }){
    emit(ShopLoginLoadinglState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value){
      print(value.data);
      emit(ShopLoginSuccesslState());
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorlState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = false;
  void changePasswordVisibility(){
    isPasswordShown = !isPasswordShown;

    suffix = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    
    emit(ShopChangePasswordVisibilityState());
  }
}