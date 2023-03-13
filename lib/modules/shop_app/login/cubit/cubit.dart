import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  
  void userLogin(){
    
  }
}