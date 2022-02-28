import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop/cubit/cubit/shop_cubit.dart';
import 'package:my_shop/cubit/states/app_states.dart';
import 'package:my_shop/models/fav_model/fav_model.dart';
import 'package:my_shop/shared/components.dart';
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      builder: (context,state){
        return ConditionalBuilder(
          builder:(context)=>ListView.separated(
              itemBuilder:(context,index)=> buidListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product,context),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
            separatorBuilder: (context , index)=> Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
          ),
          condition: state is! ShopLoadingFavouriteState ,
          fallback: (context)=>Center(
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: Image(
                    image: AssetImage('assets/images/onboarding1.jpg'),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('No Favourite Items Added Yet......',
                  style: TextStyle(
                      color: Colors.red.shade900,
                      fontFamily: 'candy',
                      fontWeight: FontWeight.bold
                  ),),
              ],
            ),
          ),
        );},
      listener: (context, state)=>{
      },
    );
  }

}
