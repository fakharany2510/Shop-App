import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:my_shop/cubit/cubit/shop_login_cubit.dart';
import 'package:my_shop/cubit/states/shop_login_states.dart';
import 'package:my_shop/layouts/homelayout/home_layout.dart';
import 'package:my_shop/modules/register/register_screen.dart';
import 'package:my_shop/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ShopLoginScreen extends StatelessWidget {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopLoginCubit(),
    child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSucessState){
            if(state.loginModel.status!){
              print(state.loginModel.status);
              Fluttertoast.showToast(
                msg: '${state.loginModel.message}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>ShopLayout()));
            }else{
              print(state.loginModel.status);
              Fluttertoast.showToast(
                msg: '${state.loginModel.message}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 30,right: 30,top: 80),
                child:Form(
                  key: formKey,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child:Image(
                            image: AssetImage('assets/images/onboarding1.jpg'),
                            height: 100,
                            width:100
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text('LOGIN' ,
                        style: TextStyle(
                            color: Colors.red.shade900,
                            fontSize:30,
                            fontFamily:'candy'
                        ),
                      ),
                      SizedBox(height: 5,),
                      Center(child: Text('For connoisseurs to always be different from everyone' ,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize:17,
                          fontFamily:'candy',
                        ),
                        textAlign: TextAlign.center,
                      ),),
                      Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
                        child:TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller:emailController ,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text('E-Mail'),
                            prefixIcon: Icon(Icons.email,color: Colors.red.shade900,),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return'Please enter your e-mail';
                            }
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
                        child:TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller:passwordController ,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text('Password'),
                            suffixIcon:Icon(Icons.visibility),
                            prefixIcon: Icon(Icons.lock,color: Colors.red.shade900,),
                          ),
                          onFieldSubmitted: (value){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).shopLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          obscureText: true,
                          validator: (value){
                            if(value!.isEmpty){
                              return'Please enter your password';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 30,),
                      defaultTextButton(
                          text: 'LOGIN',
                          onpress: (){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).shopLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }

                          }
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20,right: 20,left: 60),
                        child:Row(
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>ShopRegisterScreen()));
                                }, child:Text('Register',
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            )),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

          );
        },
    ),
    );
  }
}
