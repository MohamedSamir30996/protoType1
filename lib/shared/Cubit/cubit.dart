import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/shared/Cubit/states.dart';
import 'package:udemy_start/shared/network/local/Cache_Helper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void ModeChange({bool? fromShared}){

    if(fromShared != null){
      isDark = fromShared;
      emit(AppModeChangeState());
    }else{
      isDark = !isDark;
      CacheHelper.PutBoolData(key: "isDark", value: isDark).then((value) {
        emit(AppModeChangeState());
      });
    }
  }

}