import 'package:my_shop/models/chang_fav_model/chang_fav_model.dart';
import 'package:my_shop/models/shop_loginmodel/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

//AppMode
class AppModeState extends ShopStates {}
class ShopChangeNavBarState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSucessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

//categories
class ShopLoadingCategoriesState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}

//change favourites
class ShopLoadingChangeFavouritesState extends ShopStates{}
class ShopSuccessChangeFavouritesState extends ShopStates{
  late final ChangFavouritesModel model;

  ShopSuccessChangeFavouritesState(this.model);

}
class ShopErrorChangeFavouritesState extends ShopStates{}

//FAVOURITES
class ShopLoadingFavouriteState extends ShopStates{}
  class ShopSuccessFavouriteState extends ShopStates{}
class ShopErrorFavouriteState extends ShopStates{}

//Settings
class ShopLoadingSettingsState extends ShopStates{}
class ShopSuccessSettingsState extends ShopStates{
  final ShopLoginModel shopLoginModel;

  ShopSuccessSettingsState(this.shopLoginModel);
}
class ShopErrorSettingsState extends ShopStates{}

//update_user
//Settings
class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{
  final ShopLoginModel shopLoginModel;

  ShopSuccessUpdateUserState(this.shopLoginModel);
}
class ShopErrorUpdateUserState extends ShopStates{}