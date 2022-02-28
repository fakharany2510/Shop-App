import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/cubit/states/shop_login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop/cubit/states/shop_register_states/shop_register_states.dart';
import 'package:my_shop/models/shop_loginmodel/login_model.dart';
import 'package:my_shop/network/remote/dio_helper.dart';
import 'package:my_shop/network/remote/endpoints.dart';
class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void shopRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER,
        data:{
          'email':email,
          'name':name,
          'phone':phone,
          'password':password,
        }).then((value){
      loginModel=ShopLoginModel.fromJson(value.data);
      print(loginModel?.data?.name);
      emit(ShopRegisterSucessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState());
    });
  }

  IconData suffix= Icons.visibility;
  bool isPasswordShown=false;
  void changePasswordState(){
    isPasswordShown= !isPasswordShown;
    suffix= isPasswordShown ?  Icons.visibility : Icons.visibility_off;
  }
}