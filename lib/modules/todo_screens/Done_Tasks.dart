import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/layout/TodoApp/Cubit/Cubit.dart';
import 'package:udemy_start/layout/TodoApp/Cubit/States.dart';
import 'package:udemy_start/shared/Cubit/cubit.dart';
import 'package:udemy_start/shared/Cubit/states.dart';
import 'package:udemy_start/shared/components/components.dart';
import 'package:udemy_start/shared/components/constants.dart';

class Done_Tasks extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit,ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = ToDoCubit.get(context).doneTasks;
        return taskBuilder(tasks: tasks);
      },
    );
  }
}
