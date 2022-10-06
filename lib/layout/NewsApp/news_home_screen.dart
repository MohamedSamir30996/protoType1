import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/layout/NewsApp/Cubit/Cubit.dart';
import 'package:udemy_start/layout/NewsApp/Cubit/States.dart';
import 'package:udemy_start/modules/news_screens/Search_Screen.dart';
import 'package:udemy_start/shared/Cubit/cubit.dart';
import 'package:udemy_start/shared/components/components.dart';

class News_Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.NewsTitles[cubit.currentIndex]),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    //color: Colors.black,
                  ),
                  onPressed: () {
                    NavigateTo(context, SearchScreen());
                  }
              ),
              IconButton(
                  icon: Icon(
                    Icons.brightness_4,
                    //color: Colors.black,
                  ),
                  onPressed: () {
                    AppCubit.get(context).ModeChange();
                  }
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.ChangeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.business_center,
                  ),
                  label: "Business"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.sports_basketball,
                  ),
                  label: "Sports"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.science,
                  ),
                  label: "Science"),
            ],
          ),
          body: cubit.NewsList[cubit.currentIndex],
        );
      },
    );
  }
}
