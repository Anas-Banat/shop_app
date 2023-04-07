import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

class ShopCubit extends Cubit<ShopCubit>{
  ShopCubit() : super(ShopInitialState() as ShopCubit);
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
}