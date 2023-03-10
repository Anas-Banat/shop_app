abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginLoadinglState extends ShopLoginState {}

class ShopLoginSuccesslState extends ShopLoginState {}

class ShopLoginErrorlState extends ShopLoginState {
  final String error;
  ShopLoginErrorlState(this.error);
}

