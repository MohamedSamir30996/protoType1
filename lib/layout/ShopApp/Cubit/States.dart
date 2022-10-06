import 'package:udemy_start/models/shop_app/change_favorites_model.dart';
import 'package:udemy_start/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates
{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}

// class ShopGetProductsLoading extends ShopStates{}
//
// class ShopGetProductsSuccess extends ShopStates{}
//
// class ShopGetProductsError extends ShopStates{
//   final String error;
//
//   ShopGetProductsError(this.error);
// }
//
// class ShopGetCategoriesLoading extends ShopStates{}
//
// class ShopGetCategoriesSuccess extends ShopStates{}
//
// class ShopGetCategoriesError extends ShopStates{
//   final String error;
//   ShopGetCategoriesError(this.error);
// }
//
// class ShopGetFavoritesLoading extends ShopStates{}
//
// class ShopGetFavoritesSuccess extends ShopStates{}
//
// class ShopGetFavoritesError extends ShopStates{
//   final String error;
//   ShopGetFavoritesError(this.error);
// }
//
// class ShopGetSettingsLoading extends ShopStates{}
//
// class ShopGetSettingsSuccess extends ShopStates{}
//
// class ShopGetSettingsError extends ShopStates{
//   final String error;
//   ShopGetSettingsError(this.error);
// }
//
// class ShopSearchLoading extends ShopStates{}
//
// class ShopSearchSuccess extends ShopStates{}
//
// class ShopSearchError extends ShopStates{
//   final String error;
//   ShopSearchError(this.error);
// }