import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/register_screen/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/register_screen/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState){
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
                      Text(
                        'Register', 
                        style: Theme.of(context).textTheme.titleLarge.copyWith(
                          color: Colors.black, 
                        ),
                      ),
          
                      SizedBox(
                        height: 20.0,
                      ),
          
                      Text(
                        'Register now to browse our hot offers', 
                        style: Theme.of(context).textTheme.titleMedium.copyWith(
                        color: Colors.grey,
                        ),
                      ),
          
                      SizedBox(
                        height: 30.0,
                      ),
          
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Please enter your name';
                          }
                        },
                        lable: 'Name',
                        prefix: Icons.person, 
                      ),
          
                      SizedBox(
                        height: 15.0,
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
                        suffix: ShopRegisterCubit.get(context).suffix,
                        suffixPressed: (){
                          ShopRegisterCubit.get(context).changePasswordVisibility();
                        },
                        isPassword: ShopRegisterCubit.get(context).isPasswordShown,
                        onSubmit: (value){},
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
          
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Please enter your phone';
                          }
                        },
                        lable: 'Phone',
                        prefix: Icons.phone, 
                      ),
          
                      SizedBox(
                        height: 40,
                      ),
          
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) => defaultButton(
                        text: 'Regestre',
                        isUpperCase: true,
                        function: (){
                          if(formKey.currentState.validate()){
                            ShopRegisterCubit.get(context).userRegister(
                            name: emailController.text,
                            email: emailController.text,
                            password: passController.text,
                            phone: emailController.text,
                            );
                          }
                        }),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
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