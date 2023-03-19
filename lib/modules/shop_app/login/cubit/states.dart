import 'package:shop_app/models/shop_app/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadinglState extends ShopLoginStates {}

class ShopLoginSuccesslState extends ShopLoginStates {
  final ShopLoginModel loginModel;
  ShopLoginSuccesslState(this.loginModel);
}

class ShopLoginErrorlState extends ShopLoginStates {
  final String error;
  ShopLoginErrorlState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates {}
