import 'package:e_commerce/dio_helper.dart';
import 'package:e_commerce/end_points.dart';
import 'package:e_commerce/models/search_model.dart';
import 'package:e_commerce/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit():super(SearchInitialState());
  static SearchCubit get(context)=> BlocProvider.of(context);
  SearchModel? model;
  void search(String text){
   emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':text,
        }
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error){

      emit(SearchErrorState());
    });
  }
}