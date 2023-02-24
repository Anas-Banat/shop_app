import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter_app/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitialState());

  // To be more easily when use this cubit in many place
  // this object to call himself and get the value
  static CounterCubit get(context) => BlocProvider.of(context);
  int counter = 1;

  void minus() {
    counter--;
    // To change the state when we change the value / (ReBuild)
    emit(CounterMinusState(counter));
  }

  void plus() {
    counter++;
    emit(CounterPlusState(counter));
  }
}
