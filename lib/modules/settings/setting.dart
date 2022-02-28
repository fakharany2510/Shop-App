import 'package:flutter/material.dart';
import 'package:my_shop/cubit/cubit/shop_cubit.dart';
import 'package:my_shop/cubit/states/app_states.dart';
import 'package:my_shop/shared/components.dart';
import 'package:my_shop/shared/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class SettingScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red.shade900,
        title: Text('Settings',
          style: TextStyle(
              color: Colors.white,
              fontSize:25,
              fontFamily:'candy'
          ),
        ),
      ),
      body:BlocConsumer<ShopCubit , ShopStates>(
        listener: (context , state){
          if(state is ShopSuccessSettingsState){
            nameController.text=state.shopLoginModel.data!.name!;
            emailController.text=state.shopLoginModel.data!.email!;
            phoneController.text=state.shopLoginModel.data!.phone!;
          }
        },
        builder: (context , state){
        var model=ShopCubit.get(context).userModel;
          nameController.text=model!.data!.name!;
          emailController.text=model.data!.email!;
          phoneController.text=model.data!.phone!;
          return  ConditionalBuilder(
            condition: ShopCubit.get(context).userModel !=null ,
            builder: (context) => Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(top: 0,left: 15,right: 15),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(
                        color: Colors.red.shade900,
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.red.shade900,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child:Icon(Icons.person,
                          size: 90,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller:nameController ,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text('Name'),
                        prefixIcon: Icon(Icons.person,color: Colors.red.shade900,),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return'name must not be empty';
                        }
                      },
                    ),
                    SizedBox(height:20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller:emailController,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text('E-Mail'),
                        prefixIcon: Icon(Icons.email,color: Colors.red.shade900,),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return'e-mail must not be empty';
                        }
                      },
                    ),
                    SizedBox(height:20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller:phoneController ,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text('Phone'),
                        prefixIcon: Icon(Icons.phone,color: Colors.red.shade900,),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return'phone must not be empty';
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10,bottom:10),
                      child: defaultTextButton(
                          text: 'UPDATE',
                          onpress: (){
                            if(formKey.currentState!.validate()){
                              ShopCubit.get(context).updateUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text
                              );
                            }

                          }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultTextButton(
                          text: 'LOGOUT',
                          onpress: (){
                            signOut(context);
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child:Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width:100,
                      height:100,
                      child: Image(
                        image:AssetImage('assets/images/onboarding1.jpg'),fit: BoxFit.cover,

                      ),
                    ),
                    Text('Loading....')
                  ],
                )
            )),
          );
        },
      ),
    );
  }
}


