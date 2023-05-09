import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget{

  var formKey = GlobalKey<FormState> ();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates> (
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null, 
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
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
            
                  SizedBox(
                    height: 20.0,
                  ),
                  
                  defaultButton(
                    function: (){

                      if(formKey.currentState.validate()){
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    text: 'update',
                  ),
                  
                  SizedBox(
                    height: 20.0,
                  ),
                  
                  defaultButton(
                    function: (){
                      signnOut(context);
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}