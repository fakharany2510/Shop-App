import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop/cubit/states/app_states.dart';

class ThemeCubit extends Cubit<ShopStates>{
  ThemeCubit() : super(ShopInitialState());
  static ThemeCubit get(context)=>BlocProvider.of(context);
  //APP MODE
  bool isDark=false;
  void appMode(){
    isDark=!isDark;
    emit(AppModeState());
  }

}