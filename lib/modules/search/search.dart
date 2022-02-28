import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop/modules/search/cubit/search_cubit.dart';
import 'package:my_shop/modules/search/states/search_states.dart';
import 'package:my_shop/shared/components.dart';
class SearchScreen extends StatelessWidget {
  var searchKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build( context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit , SearchStates>(
        listener: (context , state){},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: searchKey,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),
                    child:TextFormField(
                      keyboardType: TextInputType.text,
                      controller:searchController ,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text('Search'),
                        prefixIcon: Icon(Icons.search,color: Colors.red.shade900,),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return'Please enter your Any Thing To Search For';
                        }
                      },
                      onChanged: (String text){
                        SearchCubit.get(context).saerchProducts(text);
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  if(state is SearchLoadingState)
                  LinearProgressIndicator(
                    color: Colors.red.shade900,
                  ),
                  SizedBox(height: 10,),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder:(context,index)=> buidListProduct(SearchCubit.get(context).searchModel!.data!.data![index],context),
                      itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
                      separatorBuilder: (context , index)=> Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
