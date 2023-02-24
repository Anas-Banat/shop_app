import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter_app/counter/cubit/cubit.dart';
import 'package:todo_app/modules/counter_app/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var s = BlocProvider.of(context);
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(), // To create Bloc
      child: BlocConsumer<CounterCubit, CounterStates>(
        // To check where i am / in whitch state
        listener: (BuildContext context, state) {
          if (state is CounterMinusState) {
            //print('Minus State ${state.counter}');
          }
          if (state is CounterPlusState) {
            //print('Plus State ${state.counter}');
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Counter',
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context)
                          .minus(); // To get the value from Bloc
                    },
                    child: Text('Minus'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Text(
                      '${CounterCubit.get(context).counter}', // To get the value from Bloc
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).plus();
                    },
                    child: Text('Plus'),
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
