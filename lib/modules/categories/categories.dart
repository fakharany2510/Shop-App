import 'package:flutter/material.dart';
import 'package:my_shop/cubit/cubit/shop_cubit.dart';
import 'package:my_shop/cubit/states/app_states.dart';
import 'package:my_shop/models/Categories_model/categories_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context , state){},
      builder: (context , state){
        return ConditionalBuilder(
          builder:(context)=> Padding(
              padding: EdgeInsets.all(10),
              child:ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context , index)=>buildCategories(ShopCubit.get(context).categoriesModel!.data!.data[index]),
                  separatorBuilder: (context , index)=>Container(width:100, height: 1,color: Colors.grey,),
                  itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length)
          ),
          condition: ShopCubit.get(context).homeModel !=null && ShopCubit.get(context).categoriesModel !=null,
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
                Text('Loading......',
                  style: TextStyle(
                      color: Colors.red.shade900,
                      fontFamily: 'candy',
                      fontWeight: FontWeight.bold
                  ),),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget buildCategories(DataModel model)=>Padding(
    padding: EdgeInsets.only(top: 10,bottom: 10),
    child:Row(
      children: [
        Image(image: NetworkImage('${model.image}'),
          height: 130,
          width: 130,
        ),
        Text('${model.name}',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'candy',
              fontWeight: FontWeight.w400
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios,color: Colors.black,),
          onPressed: (){},
        )

      ],
    ),
  );
  }

