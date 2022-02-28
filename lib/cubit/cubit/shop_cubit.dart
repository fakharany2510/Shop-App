import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop/cubit/states/app_states.dart';
import 'package:my_shop/models/Categories_model/categories_model.dart';
import 'package:my_shop/models/chang_fav_model/chang_fav_model.dart';
import 'package:my_shop/models/fav_model/fav_model.dart';
import 'package:my_shop/models/shop_loginmodel/login_model.dart';
import 'package:my_shop/models/shop_model/shop_model.dart';
import 'package:my_shop/modules/categories/categories.dart';
import 'package:my_shop/modules/favourites/favourite.dart';
import 'package:my_shop/modules/products/products.dart';
import 'package:my_shop/modules/settings/setting.dart';
import 'package:my_shop/network/remote/dio_helper.dart';
import 'package:my_shop/network/remote/endpoints.dart';
import 'package:my_shop/shared/constant.dart';
class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super (ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);


  //HomeProducts
  HomeModel? homeModel;
  Map<int? ,  bool?> favourites={};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: Home,
    ).then((value){
      homeModel=HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favourites.addAll({
          element.id:element.in_favorites,
        });
      });
      print(favourites.toString());
      print(homeModel?.data?.banners[0].image);
      emit(ShopSucessHomeDataState());
    }).catchError((error){
      emit(ShopErrorHomeDataState());
     print(error.toString());
    });
  }
//Categories
  CategoriesModel? categoriesModel;
  void getProductsCategory(){
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(url: 'categories',token: token).then((value){
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error);
      emit(ShopErrorCategoriesState());
    });
  }
//ChangeFavoutites
  ChangFavouritesModel? changFavouritesModel;
  void ChangeFavourites(int favProductId){
    favourites[favProductId] =  !favourites[favProductId]! ;
    emit(ShopLoadingChangeFavouritesState());
    DioHelper.postData(
        url: 'favorites',
        data: {'product_id' : favProductId},
        token: 'Caq01yuHOvqpZdrIuDv5XND43GxG9S1YjEitiwtYG8Ohy7lkjL5A5Grs1nvh7jQBgm170P'
    ).then((value){
      changFavouritesModel = ChangFavouritesModel.fromJson(value.data);
      print(value.data);
      if(!changFavouritesModel!.status!){
        favourites[favProductId] =  !favourites[favProductId]! ;
      }else{
        getFavouritesProducts();
      }
      emit(ShopSuccessChangeFavouritesState(changFavouritesModel!));
    }).catchError((error){
      favourites[favProductId] =  !favourites[favProductId]! ;
      emit(ShopErrorChangeFavouritesState());
    });
  }

  //get Favourites
  FavoritesModel? favoritesModel;
  void getFavouritesProducts(){
    emit(ShopLoadingFavouriteState());
    DioHelper.getData(
        url: 'favorites'
        ,token: 'Caq01yuHOvqpZdrIuDv5XND43GxG9S1YjEitiwtYG8Ohy7lkjL5A5Grs1nvh7jQBgm170P'
    ).then((value){
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(ShopSuccessFavouriteState());
    }).catchError((error){
      print(error);
      emit(ShopErrorFavouriteState());
    });
  }
  //get profile
  ShopLoginModel? userModel;
  void getUser(){
    emit(ShopLoadingSettingsState());
    DioHelper.getData(
        url: Profile
        ,token: 'Caq01yuHOvqpZdrIuDv5XND43GxG9S1YjEitiwtYG8Ohy7lkjL5A5Grs1nvh7jQBgm170P'
    ).then((value){
      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessSettingsState(userModel!));
    }).catchError((error){
      print(error);
      emit(ShopErrorSettingsState());
    });
  }

  //update profile
  void updateUser({
  required String name,
    required String email,
    required String phone
}){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
        url: Update_Profile
        ,token:'Caq01yuHOvqpZdrIuDv5XND43GxG9S1YjEitiwtYG8Ohy7lkjL5A5Grs1nvh7jQBgm170P',
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        }
    ).then((value){
      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error){
      print(error);
      emit(ShopErrorUpdateUserState());
    });
  }


  int currentIndex=0;

  List<Widget> screens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingScreen(),
  ];

  void changeBottom(int value){
    currentIndex=value;
    emit(ShopChangeNavBarState());
  }



}

