import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/layout/ShopApp/Cubit/States.dart';
import 'package:udemy_start/models/shop_app/categories_model.dart';
import 'package:udemy_start/models/shop_app/change_favorites_model.dart';
import 'package:udemy_start/models/shop_app/favorites_model.dart';
import 'package:udemy_start/models/shop_app/home_model.dart';
import 'package:udemy_start/models/shop_app/login_model.dart';
import 'package:udemy_start/modules/shop_screens/Categories_Screen.dart';
import 'package:udemy_start/modules/shop_screens/Favorites_Screen.dart';
import 'package:udemy_start/modules/shop_screens/Products_Screen.dart';
import 'package:udemy_start/modules/shop_screens/Settings_Screen.dart';
import 'package:udemy_start/shared/components/constants.dart';
import 'package:udemy_start/shared/network/end_points.dart';
import 'package:udemy_start/shared/network/remote/Dio_Helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> ShopList = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  List<String> ShopTitles = [
    'Products',
    'Categories',
    'Favorites',
    'Setting',
  ];


  void ChangeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  ShopHomeModel? homeModel;

  Map<int, bool> favorites = {};

  void GetHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.GetData(
      url: HOME,
      token: token,
    ).then((value){
      homeModel = ShopHomeModel.fromJson(value.data);

      homeModel?.data?.products.forEach((element) {
        favorites.addAll({
          element.id!:element.in_favorites!,
        });
      });


      PrintFullText(homeModel!.data!.banners[0].image!);
      print(homeModel?.status);
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.GetData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.PostData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }


  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.GetData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.GetData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      PrintFullText(userModel!.data!.name!);
      print("flfl");

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      PrintFullText(userModel!.data!.name!);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}



//.>>>>>>>>>>>>>>>>>>


  // List<dynamic>? business = [];
  //
  //
  // void getProducts (){
  //
  //   emit(ShopGetProductsLoading());
  //
  //   DioHelper.GetData(
  //       url: 'v2/top-headlines',
  //       query: {
  //         "country":"eg",
  //         "category":"business",
  //         "apiKey":"e921c44dd1904f69b75fe8d9cf1a34d4",
  //       }).then((value) {
  //     business = value.data['articles'];
  //     emit(ShopGetProductsSuccess());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(ShopGetProductsError(error.toString()));
  //   });
  // }
  //
  // List<dynamic>? sports = [];
  //
  //
  // void getCategories (){
  //
  //   emit(ShopGetCategoriesLoading());
  //
  //   if(sports!.length == 0){
  //     DioHelper.GetData(url: "v2/top-headlines",
  //         query: {
  //           "country":"eg",
  //           "category":"sports",
  //           "apiKey":"65f7f556ec76449fa7dc7c0069f040ca",
  //         }).then((value) {
  //       sports = value.data['articles'];
  //       emit(ShopGetCategoriesSuccess());
  //     }).catchError((error){
  //       print(error.toString());
  //       emit(ShopGetCategoriesError(error.toString()));
  //     });
  //   }else{
  //     emit(ShopGetCategoriesSuccess());
  //   }
  // }
  //
  // List<dynamic>? science = [];
  //
  //
  // void getFavorites (){
  //
  //   emit(ShopGetFavoritesLoading());
  //
  //   if(science!.length == 0){
  //     DioHelper.GetData(url: "v2/top-headlines",
  //         query: {
  //           "country":"eg",
  //           "category":"science",
  //           "apiKey":"65f7f556ec76449fa7dc7c0069f040ca",
  //         }).then((value) {
  //       science = value.data['articles'];
  //       emit(ShopGetFavoritesSuccess());
  //     }).catchError((error){
  //       print(error.toString());
  //       emit(ShopGetFavoritesError(error.toString()));
  //     });
  //   }else{
  //     emit(ShopGetFavoritesSuccess());
  //   }
  //
  // }
  //
  // List<dynamic>? Search = [];
  //
  // void getSearch (String value){
  //
  //   emit(ShopSearchLoading());
  //
  //   DioHelper.GetData(url: "v2/everything",
  //       query: {
  //         "q":"$value",
  //         "apiKey":"65f7f556ec76449fa7dc7c0069f040ca",
  //       }).then((value) {
  //     Search = value.data['articles'];
  //     emit(ShopSearchSuccess());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(ShopSearchError(error.toString()));
  //   });
  // }}

