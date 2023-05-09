import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/modules/shop_app/register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status){
              print(state.loginModel.data.token);
              print(state.loginModel.message);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
                ).then((value){
                  token = state.loginModel.data.token;                  

                  navigateAndFinish(context, ShopLayout(),
                  );
                });
            } else {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
           return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN', style: Theme.of(context).textTheme.titleLarge.copyWith(
                          color: Colors.black, 
                        ),),
                        SizedBox(
                          height: 20.0,
                        ),
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
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: ShopLoginCubit.get(context).isPasswordShown,
                          onSubmit: (value){
                            if(formKey.currentState.validate()){
                              ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passController.text,
                              );
                            }
                          },
                          validate: (String value){
                            if(value.isEmpty){
                              return 'Password is too short';
                            }
                          },
                          lable: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                          text: 'Login',
                          isUpperCase: true,
                          function: (){
                            if(formKey.currentState.validate()){
                              ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passController.text,
                              );
                            }
                          }),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
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
            ),
          );
        },
      ),
    );
  }
}