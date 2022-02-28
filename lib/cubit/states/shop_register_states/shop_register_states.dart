import 'package:my_shop/models/shop_loginmodel/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSucessState extends ShopRegisterStates{
  final ShopLoginModel loginModel;
  ShopRegisterSucessState(this.loginModel);
}
class ShopRegisterErrorState extends ShopRegisterStates{
}