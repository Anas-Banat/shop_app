import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget{

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates> (
      listener: (context, state) {
        if(state is ShopSuccessUserDataState){
          nameController.text = state.loginModel.data.name;
          emailController.text = state.loginModel.data.email;
          phoneController.text = state.loginModel.data.phone;
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null, 
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String value){
                    if(value.isEmpty){
                      return "Name must not be empty";
                    }
                    return null;
                  },
                  lable: 'Name',
                  prefix: Icons.person,
                ),
                
                SizedBox(
                  height: 20.0,
                ),
        
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (String value){
                    if(value.isEmpty){
                      return "Email must not be empty";
                    }
                    return null;
                  },
                  lable: 'Email Address',
                  prefix: Icons.email,
                ),
        
                SizedBox(
                  height: 20.0,
                ),
                
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (String value){
                    if(value.isEmpty){
                      return "Phone must not be empty";
                    }
                    return null;
                  },
                  lable: 'Phone',
                  prefix: Icons.phone,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}