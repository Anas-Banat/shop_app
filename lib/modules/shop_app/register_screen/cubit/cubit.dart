import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/register_screen/cubit/states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  
  ShopLoginModel loginModel;

  void userRegister({
    String name,
    String email,
    String password,
    String phone,
  }){
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value){
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = false;
  void changePasswordVisibility(){
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}