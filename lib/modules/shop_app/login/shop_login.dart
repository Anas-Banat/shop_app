import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('LOGIN', style: Theme.of(context).textTheme.titleLarge.copyWith(
                  color: Colors.black, 
                ),),
                Text('Login now to browse our hot offers', style: Theme.of(context).textTheme.titleMedium.copyWith(
                  color: Colors.grey,
                ),),
                SizedBox(
                  height: 30.0,
                ),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (String value){
                    if(value.isEmpty){
                      return 'Please enter your email address';
                    }
                  },
                  lable: 'Email Address',
                  prefix: Icons.email_outlined,
                  
                ),
                SizedBox(
                  height: 15.0,
                ),
                defaultFormField(
                  controller: passController,
                  type: TextInputType.visiblePassword,
                  suffix: Icons.visibility_outlined,
                  validate: (String value){
                    if(value.isEmpty){
                      return 'Password is too short';
                    }
                  },
                  lable: 'Password',
                  prefix: Icons.lock_outline,
                ),
                SizedBox(
                  height: 15.0,
                ),
                defaultButton(
                  text: 'Login',
                  isUpperCase: true,
                  function: (){},
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('don\'t have an account?',),
                    defaultTextButton(
                      function: (){
                        navigateTo(context, RegisterScreen());
                      },
                      text: 'Register',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}