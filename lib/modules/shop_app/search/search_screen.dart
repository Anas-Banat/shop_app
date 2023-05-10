import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'Please enter a search query';
                      }
                      return null;
                    },
                    lable: 'Search',
                    prefix: Icons.search,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}