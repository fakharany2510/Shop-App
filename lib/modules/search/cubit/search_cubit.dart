import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop/models/search_model/saerch_model.dart';
import 'package:my_shop/modules/search/states/search_states.dart';
import 'package:my_shop/network/remote/dio_helper.dart';
import 'package:my_shop/network/remote/endpoints.dart';
class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  
  SearchModel? searchModel;
  void saerchProducts(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SERCH,
        data: {
          'text':text,
    }).then((value){
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
      print(error);
    });
  }
  
  
}