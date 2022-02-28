import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/cubit/states/shop_login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop/models/shop_loginmodel/login_model.dart';
import 'package:my_shop/network/remote/dio_helper.dart';
import 'package:my_shop/network/remote/endpoints.dart';
class ShopLoginCubit extends Cubit<ShopLoginStates>{
   ShopLoginCubit() : super(ShopLoginInitialState());
   static ShopLoginCubit get(context)=>BlocProvider.of(context);

   ShopLoginModel? loginModel;

   void shopLogin({
  required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN,
        data:{
            'email':email,
          'password':password,
        }).then((value){
          loginModel=ShopLoginModel.fromJson(value.data);
          print(loginModel?.data?.name);
          emit(ShopLoginSucessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState());
    });
  }

  IconData suffix= Icons.visibility;
  bool isPasswordShown=false;
  void changePasswordState(){
    isPasswordShown= !isPasswordShown;
    suffix= isPasswordShown ?  Icons.visibility : Icons.visibility_off;
  }
}