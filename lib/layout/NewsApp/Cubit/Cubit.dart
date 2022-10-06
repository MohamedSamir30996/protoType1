import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/layout/NewsApp/Cubit/States.dart';
import 'package:udemy_start/modules/news_screens/Business_Screen.dart';
import 'package:udemy_start/modules/news_screens/Science_Screen.dart';
import 'package:udemy_start/modules/news_screens/Setting_Screen.dart';
import 'package:udemy_start/modules/news_screens/Sports_Screen.dart';
import 'package:udemy_start/shared/network/remote/Dio_Helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> NewsList = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<String> NewsTitles = [
    'Business News',
    'Sports News',
    'Science tasks',
  ];


  void ChangeIndex(int index) {
    currentIndex = index;

    if(index==1){
      getSports();
    }
    if(index==2){
      getScience();
    }

    emit(NewsChangeBottomNavState());
  }

  List<dynamic>? business = [];


  void getBusiness (){

    emit(NewsGetBusinessLoading());

    DioHelper.GetData(
        url: 'v2/top-headlines',
        query: {
          "country":"eg",
          "category":"business",
          "apiKey":"e921c44dd1904f69b75fe8d9cf1a34d4",
        }).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccess());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessError(error.toString()));
    });
}

  List<dynamic>? sports = [];


  void getSports (){

    emit(NewsGetSportsLoading());

    if(sports!.length == 0){
      DioHelper.GetData(url: "v2/top-headlines",
          query: {
            "country":"eg",
            "category":"sports",
            "apiKey":"65f7f556ec76449fa7dc7c0069f040ca",
          }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccess());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsError(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccess());
    }

  }

  List<dynamic>? science = [];


  void getScience (){

    emit(NewsGetScienceLoading());

    if(science!.length == 0){
      DioHelper.GetData(url: "v2/top-headlines",
          query: {
            "country":"eg",
            "category":"science",
            "apiKey":"65f7f556ec76449fa7dc7c0069f040ca",
          }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccess());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceError(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccess());
    }


  }


  List<dynamic>? Search = [];


  void getSearch (String value){

    emit(NewsSearchLoading());


      DioHelper.GetData(url: "v2/everything",
          query: {
            "q":"$value",
            "apiKey":"65f7f556ec76449fa7dc7c0069f040ca",
          }).then((value) {
        Search = value.data['articles'];
        emit(NewsSearchSuccess());
      }).catchError((error){
        print(error.toString());
        emit(NewsSearchError(error.toString()));
      });



  }




}