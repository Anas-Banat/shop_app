import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_app/cubit/cubit.dart';
import 'package:todo_app/layout/news_app/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;

        // return ConditionalBuilder(
        //   condition: state
        //       is! newsGetBusinessLoadingState, // it shold be like other screens "list.length > 0,"
        //   builder: (context) => ListView.separated(
        //     physics:
        //         BouncingScrollPhysics(), // To remove the color from the top when we drag the screen to the down
        //     itemBuilder: (context, index) => buildArticalItem(
        //         list), //NewsCubit.get(context).business[index] // to get the data from api but its not working
        //     separatorBuilder: (context, index) => myDivider(),
        //     itemCount: 10,
        //   ),
        //   fallback: (context) => Center(child: CircularProgressIndicator()),
        // );
        return articleBuilder(list, context);
      },
    );
  }
}
