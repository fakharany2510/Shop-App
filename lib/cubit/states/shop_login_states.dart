import 'package:my_shop/models/shop_loginmodel/login_model.dart';

abstract class ShopLoginStates{}
class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSucessState extends ShopLoginStates{
  final ShopLoginModel loginModel;
  ShopLoginSucessState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginStates{
}