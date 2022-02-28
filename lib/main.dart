import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_shop/styles/themes.dart';
import 'bloc/bloc_observer.dart';
import 'cubit/cubit/shop_cubit.dart';
import 'cubit/cubit/shop_login_cubit.dart';
import 'cubit/cubit/theme_cubit.dart';
import 'cubit/states/app_states.dart';
import 'modules/onBoarding/onboardingscreen.dart';
import 'network/remote/dio_helper.dart';
void main() {
  Bloc.observer= MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context)=>ThemeCubit(),),
          BlocProvider(
            create: (BuildContext context)=>ShopCubit()..getHomeData()..getProductsCategory()..getUser()..getFavouritesProducts(),),


        ],
        child: BlocConsumer<ThemeCubit,ShopStates>(
          listener: (context , state){},
          builder: (context , state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightMood,
              darkTheme: darkMood,
              themeMode: ThemeCubit.get(context).isDark ? ThemeMode.dark:ThemeMode.light,
              home: OnBoardingScreen(),
            );
          },
        )
    );
  }
}
