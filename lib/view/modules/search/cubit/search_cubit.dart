import 'package:ecommarce_app/constans.dart';
import 'package:ecommarce_app/data/remote/dio_helper.dart';
import 'package:ecommarce_app/data/remote/end_point.dart';
import 'package:ecommarce_app/models/search_model.dart';
import 'package:ecommarce_app/view/modules/search/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;

  void Search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {"text": text},
    ).then((value) {
      model=SearchModel.fromjson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
