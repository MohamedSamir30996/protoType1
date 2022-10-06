import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_start/layout/TodoApp/Cubit/States.dart';
import 'package:udemy_start/modules/todo_screens/Archive_Tasks.dart';
import 'package:udemy_start/modules/todo_screens/Done_Tasks.dart';
import 'package:udemy_start/modules/todo_screens/New_tasks.dart';


class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(ToDoInitialState());

  static ToDoCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> TaskList = [
    New_Tasks(),
    Done_Tasks(),
    Archive_Tasks(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archive tasks',
  ];

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(ToDoChangeBottomNavState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];


  createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print("DataBase has been Created");
      database
          .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, date TEXT, title TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('Table is Created');
      }).catchError((error) {
        print('Error While Creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      getFromDataBase(database);

      print("DataBase has been Opened");
    }).then((value) {
      database = value;
      emit(ToDoCreateDatabase());
    });
  }

  Future insertotable({
    required date, required title, required time
  }) async {
    return await database.transaction((txn) => txn
        .rawInsert(
          'INSERT INTO tasks (date, title, time, status) VALUES("${date}", "${title}", "${time}", "new")')
          .then((value) {
        print("$value Inserted Successfully");
        emit(ToDoInsertDatabase());
        getFromDataBase(database);
      }).catchError((error) {
        print("Record did not inserted ${error.toString()}");
      }));
  }


  void getFromDataBase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    emit(ToDoGetReloadDatabase());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      emit(ToDoGetDatabase());

      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else
          archiveTasks.add(element);
      });
    });
  }

  void UpdateDataBase({
    required String status,
    required int? id,
  }) {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', ['$status', id]).then((
        value) {
      getFromDataBase(database);
      emit(ToDoUpdateDatabase());
    });
  }


  void DeleteDataBase({
    required int? id,
  }) {
    database.rawUpdate('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getFromDataBase(database);
      emit(ToDoDeleteDatabase());
    });
  }


  bool isButtonsheetshown = false;
  IconData fabicon = Icons.edit;


  void ChangeButtonIcon({
    required bool IsShown,
    required IconData Icon,

  }) {
    isButtonsheetshown = IsShown;
    fabicon = Icon;
    emit(ToDoButtonChangeIcon());
  }

}