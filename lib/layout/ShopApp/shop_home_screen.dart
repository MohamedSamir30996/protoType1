import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/layout/ShopApp/Cubit/Cubit.dart';
import 'package:udemy_start/layout/ShopApp/Cubit/States.dart';
import 'package:udemy_start/modules/shop_screens/login_screen/cubit/States.dart';
import 'package:udemy_start/modules/shop_screens/search_screen/Search_Screen.dart';
import 'package:udemy_start/shared/Cubit/cubit.dart';
import 'package:udemy_start/shared/components/components.dart';

class ShopHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.ShopTitles[cubit.currentIndex]),
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
                    Icons.home,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: "Favorites"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: "Settings"),
            ],
          ),
          body: cubit.ShopList[cubit.currentIndex],
        );
      },
    );
  }
}
