import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_shop/cubit/cubit/shop_cubit.dart';
import 'package:my_shop/cubit/states/app_states.dart';
import 'package:my_shop/models/Categories_model/categories_model.dart';
import 'package:my_shop/models/shop_model/shop_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      builder: (context,State){
        return ConditionalBuilder(
        builder:(context)=> puildProductScreen(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel! , context),
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
      );},
      listener: (context, state)=>{
      if(state is ShopSuccessChangeFavouritesState){
        if(!state.model.status!){
      Fluttertoast.showToast(
        msg: '${state.model.message}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red.shade500,
        textColor: Colors.white,
        fontSize: 16.0,
      )
    }
  }
      },
    );
  }
  Widget puildProductScreen(HomeModel model , CategoriesModel categoriesModel , context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items:model.data?.banners.map((e)=>Image(
            image: NetworkImage('${e.image}'),
            fit: BoxFit.cover,
            width: double.infinity,
          )).toList(),
          options: CarouselOptions(
            disableCenter: true,
            height: 230,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height:10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.red.shade900,
                child:Text('Categories',
                  style: TextStyle(
                    fontFamily: 'candy',
                    fontWeight: FontWeight.normal,
                    fontSize: 25,
                    color:Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                color: Colors.grey.shade100,
                width: double.infinity,
                height: 100,
                child:ListView.separated(
                  scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>buildCategories(ShopCubit.get(context).categoriesModel!.data!.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(width:10,),
                    itemCount:categoriesModel.data!.data.length),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.red.shade900,
                child:Text('New Products',
                  style: TextStyle(
                    fontFamily: 'candy',
                    fontWeight: FontWeight.normal,
                    fontSize: 25,
                    color:Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5,),
        Container(
          color: Colors.grey.shade300,
          child: GridView.count(
              crossAxisCount: 2,
              reverse: false,
             physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 1/1.48,
            shrinkWrap: true,
            children: List.generate(model.data!.products.length, (index) => buildGridViewProducts(model.data!.products[index] , context)),
          ),
        ),
      ],
    ),
  );

  Widget buildGridViewProducts(ProductModel model , context)=>Container(
    color: Colors.white,
    child:Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Image(image: NetworkImage('${model.image}'),height: 200,),
            if(model.discount!=0)
            Container(
             padding: EdgeInsets.symmetric(horizontal:10),
              color: Colors.red.shade900,
              child: Text('Discount',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'candy',
                fontWeight: FontWeight.normal,
                color: Colors.white
              ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    height:1.4
                ),
                maxLines: 2,
              ),
              Row(
                children: [
                  Text('${model.price}',
                    style: TextStyle(
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(width: 10,),
                  if(model.discount!=0)
                    Text('${model.old_price}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          decoration: TextDecoration.lineThrough
                      ),
                      maxLines: 1,
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).ChangeFavourites(model.id!);
                    },
                    icon: CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favourites[model.id]! ?  Colors.grey : Colors.red.shade900 ,
                      child: Icon(Icons.favorite_border_outlined, color: Colors.white,),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );

  Widget buildCategories(DataModel model )=>Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Container(
        width: 100,
        height: 100,
        child: Image(
          image: NetworkImage('${model.image}'),
          fit: BoxFit.cover,
        ),
      ),
      Container(
        width: 100,
        height: 20,
        color: Colors.red.shade900.withOpacity(.9),
        child: Text('${model.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ],
  );
}
