import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/models/shop_app/login_model.dart';
import 'package:udemy_start/modules/shop_screens/login_screen/cubit/States.dart';
import 'package:udemy_start/shared/network/end_points.dart';
import 'package:udemy_start/shared/network/remote/Dio_Helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {

  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
    
    DioHelper.PostData(
        url: LOGIN,
        data:
        {
          'email':email,
          'password':password,
        },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccess(loginModel!));
    }).catchError((error){
      emit(ShopLoginError(error.toString()));
    });
  }

  bool isPassword = true ;
  IconData suffix = Icons.visibility;

  void ChangePasswordVisibility(){

    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;

    emit(ShopChangePasswordVisibility());

  }
}
