import 'package:shop_app/modules/shop_app/login/shop_login.dart';
import 'package:shop_app/shared/components/components.dart';

import '../network/local/cache_helper.dart';

List<Map> tasks = [];

void signnOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value) {
      navigateAndFinish(context, ShopLoginScreen(),);
      }
    }
  );
  }

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

String token = '';
