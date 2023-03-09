import 'package:flutter/material.dart';

class ShopLoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('LOGIN', style: Theme.of(context).textTheme.headline6,)
        ],
      ),
    );
  }
}