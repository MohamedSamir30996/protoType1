import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/layout/NewsApp/Cubit/Cubit.dart';
import 'package:udemy_start/layout/NewsApp/news_home_screen.dart';
import 'package:udemy_start/layout/ShopApp/Cubit/Cubit.dart';
import 'package:udemy_start/layout/ShopApp/shop_home_screen.dart';
import 'package:udemy_start/layout/TodoApp/todo_home_screen.dart';
import 'package:udemy_start/modules/basics_screens/login_screen.dart';
import 'package:udemy_start/modules/bmi_screens/BMI_Calculator.dart';
import 'package:udemy_start/modules/shop_screens/Categories_Screen.dart';
import 'package:udemy_start/modules/shop_screens/On_Boarding_Screen.dart';
import 'package:udemy_start/modules/shop_screens/Products_Screen.dart';
import 'package:udemy_start/modules/shop_screens/login_screen/Shop_Login_Screen.dart';
import 'package:udemy_start/shared/Cubit/cubit.dart';
import 'package:udemy_start/shared/Cubit/states.dart';
import 'package:udemy_start/shared/Cubit_Observer.dart';
import 'package:udemy_start/shared/components/variables.dart';
import 'package:udemy_start/shared/network/local/Cache_Helper.dart';
import 'package:udemy_start/shared/network/remote/Dio_Helper.dart';
import 'package:udemy_start/shared/styles/themes.dart';

import 'modules/shop_screens/search_screen/Search_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool? isDark = CacheHelper.GetData(key: 'isDark');
  bool? onBoarding = CacheHelper.GetData(key: 'onBoarding');
  String? token = CacheHelper.GetData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      print(token);
      widget = ShopLoginScreen();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..ModeChange(fromShared: isDark),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..GetHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LightTheme,
            darkTheme: DarkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
