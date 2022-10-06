import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy_start/layout/TodoApp/Cubit/Cubit.dart';
import 'package:udemy_start/layout/TodoApp/Cubit/States.dart';
import 'package:udemy_start/shared/components/components.dart';

class Todo_home_Screen extends StatelessWidget
{


  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ToDoCubit()..createDatabase(),
      child: BlocConsumer<ToDoCubit,ToDoStates>(
        listener: (context, state) {
          if (state is ToDoInsertDatabase){
            Navigator.pop(context);
              titleController.clear();
              timeController.clear();
              dateController.clear();
          }
        },
        builder: (context, state) {
          ToDoCubit cubit = ToDoCubit.get(context);
          return Scaffold(
            key: ScaffoldKey,
            appBar: AppBar(
              //automaticallyImplyLeading: false,
              title: Text(cubit.titles[cubit.currentIndex]),
            ),

            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isButtonsheetshown) {
                    if(formKey.currentState!.validate()){
                      cubit.insertotable(date: dateController.text, title: titleController.text, time: timeController.text).
                      then((value) {
                        cubit.ChangeButtonIcon(IsShown: false, Icon: Icons.edit);
                        // setState(() {
                        //   fabicon = Icons.edit;
                        // });
                      });
                    }
                  } else {
                    ScaffoldKey.currentState!.showBottomSheet(
                          (context) => Container(
                        //onVerticalDragStart: (_) {}, with gesterdetector
                        padding: EdgeInsets.all(20),
                        color: Colors.grey[100],
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DefaultFormField(
                                  controller: titleController,
                                  showCursor: true,
                                  textType: TextInputType.text,
                                  lable: "Title",
                                  prefix: Icons.title,
                                  valid: (String? value) {
                                    if (value!.isEmpty) {
                                      return "The value must not be empty";
                                    }
                                    return null;
                                  }),
                              SizedBox(height: 15),
                              DefaultFormField(
                                  controller: timeController,
                                  showCursor: true,
                                  readOnly: true,
                                  textType: TextInputType.datetime,
                                  lable: "Time",
                                  prefix: Icons.watch_later_rounded,
                                  OnTap: ()
                                  {
                                    showTimePicker(context: context, initialTime: TimeOfDay.now())
                                        .then((value) {
                                      timeController.text = value!.format(context).toString();
                                    }).catchError((error){
                                      print("Error while taking clock value ${error.toString()}");
                                    });
                                  },
                                  valid: (String? value) {
                                    if (value!.isEmpty) {
                                      return "The value must not be empty";
                                    }
                                    return null;
                                  }),
                              SizedBox(height: 15),
                              DefaultFormField(
                                  controller: dateController,
                                  readOnly: true,
                                  showCursor: true,
                                  textType: TextInputType.datetime,
                                  lable: "Date",
                                  prefix: Icons.calendar_today_rounded,
                                  OnTap: ()
                                  {
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse("2023-06-25")
                                    ).then((value) {
                                      dateController.text = DateFormat.yMMMd().format(value!);
                                    }).catchError((error){
                                      print("Date did not record ${error.toString()}");
                                    });
                                  },
                                  valid: (String? value) {
                                    if (value!.isEmpty) {
                                      return "The value must not be empty";
                                    }
                                    return null;
                                  }),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20,
                    ).closed.then((value) {
                      cubit.ChangeButtonIcon(IsShown: false, Icon: Icons.edit);
                      // setState(() {
                      //   fabicon = Icons.edit;
                      // });
                    });
                    cubit.ChangeButtonIcon(IsShown: true, Icon: Icons.add);
                    // setState(() {
                    //   fabicon = Icons.add;
                    //   titleController.clear();
                    //   timeController.clear();
                    //   dateController.clear();
                    // });
                  }
                },
                child: Icon(
                  cubit.fabicon,
                )),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.done_outline_rounded,
                    ),
                    label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive,
                    ),
                    label: "Archive"),
              ],
            ),



            body: ConditionalBuilder(condition: state is! ToDoGetReloadDatabase,
              builder: (context) => cubit.TaskList[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

}
