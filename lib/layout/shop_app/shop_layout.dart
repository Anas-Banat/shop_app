import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/login/shop_login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salla'),
      ),
      body: TextButton(
        onPressed: () {
          CacheHelper.removeData(key: 'token').then((value) {
            if(value) {
              navigateAndFinish(context, ShopLoginScreen(),);
            }
          });
        },
        child: Text('SIGN OUT',
        ),
      ),
    );
  }
}