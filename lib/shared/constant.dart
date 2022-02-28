import 'package:flutter/material.dart';
import 'package:my_shop/modules/login/login_screen.dart';

String? token ='';

signOut(context){
  Navigator.push(context, MaterialPageRoute(builder: (builder)=>ShopLoginScreen()));
}