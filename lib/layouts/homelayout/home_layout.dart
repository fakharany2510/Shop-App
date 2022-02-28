import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_shop/cubit/cubit/shop_cubit.dart';
import 'package:my_shop/cubit/states/app_states.dart';
import 'package:my_shop/modules/search/search.dart';
import 'package:my_shop/modules/settings/setting.dart';
class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SettingScreen()));
                },
                icon: Icon(Icons.settings,color: Colors.white,),
              ),
              IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SearchScreen()));
                },
                icon: Icon(Icons.search, color:Colors.white),
              ),
            ],
            title: Text('Taswaq',
            style: TextStyle(
              fontFamily: 'candy',
              color: Colors.white,
              letterSpacing:1,
              fontSize: 30,
              fontWeight: FontWeight.normal
            ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.red.shade900,
          ),
          body: ShopCubit.get(context).screens[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: Colors.red.shade900,
            height:60,
            buttonBackgroundColor: Colors.red.shade900,
            animationCurve: Curves.fastLinearToSlowEaseIn,
            animationDuration: Duration(milliseconds: 750),
            items: <Widget>[
              Icon(Icons.home, size: 30,color: Colors.white,),
              Icon(Icons.apps, size: 30,color: Colors.white),
              Icon(Icons.favorite, size: 30,color: Colors.white),
              //Icon(Icons.settings, size: 30),
            ],
            index: ShopCubit.get(context).currentIndex,
            onTap: (index) {
              ShopCubit.get(context).changeBottom(index);
            },
          ),
        );
      },
      listener: (context,State){},
    );
  }
}
