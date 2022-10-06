import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/modules/counter_screens/cubit/cubit.dart';
import 'package:udemy_start/modules/counter_screens/cubit/states.dart';

class CounterScreen extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context, state) {
          if(state is CounterMinusState){
            //print("Minus State ${state.counter}");
          }
          if(state is CounterPlusState){
            //print("Plus State ${state.counter}");
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  'Counter'
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: (){
                    CounterCubit.get(context).Minus();
                  },
                      child: Text(
                        "-",
                        style: TextStyle(
                          fontSize: 85,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                  Text(
                    "${CounterCubit.get(context).counter}",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(onPressed: (){
                    CounterCubit.get(context).Plus();
                  },
                      child: Text(
                        "+",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      )
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
