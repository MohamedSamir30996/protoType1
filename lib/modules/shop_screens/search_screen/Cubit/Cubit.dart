import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/models/shop_app/search_model.dart';
import 'package:udemy_start/modules/shop_screens/search_screen/Cubit/States.dart';
import 'package:udemy_start/shared/components/constants.dart';
import 'package:udemy_start/shared/network/end_points.dart';
import 'package:udemy_start/shared/network/remote/Dio_Helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.PostData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}