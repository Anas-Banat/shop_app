abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadinglState extends ShopLoginStates {}

class ShopLoginSuccesslState extends ShopLoginStates {}

class ShopLoginErrorlState extends ShopLoginStates {
  final String error;
  ShopLoginErrorlState(this.error);
}

