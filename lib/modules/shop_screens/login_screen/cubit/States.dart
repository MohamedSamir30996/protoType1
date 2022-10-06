import 'package:udemy_start/models/shop_app/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates {}


class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccess extends ShopLoginStates{
  final ShopLoginModel loginModel;
  ShopLoginSuccess(this.loginModel);}

class ShopLoginError extends ShopLoginStates{
  final String error;
  ShopLoginError(this.error);
}

class ShopChangePasswordVisibility extends ShopLoginStates{}