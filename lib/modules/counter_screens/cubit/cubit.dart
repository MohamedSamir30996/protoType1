import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/modules/counter_screens/cubit/states.dart';


class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit() : super(CounterInitialState());


  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 0 ;



  void Plus (){
    counter++ ;
    emit(CounterPlusState(counter));
}

  void Minus(){
    counter--;
    emit(CounterMinusState(counter));
}

}