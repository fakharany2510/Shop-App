import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/cubit/cubit/shop_cubit.dart';

Widget defaultTextButton({
  required VoidCallback onpress,
  required String  text,
})=>TextButton(onPressed:onpress, child: Text(text,
  style: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'candy'
  ),
),
  style:ButtonStyle(
    backgroundColor:MaterialStateProperty.all<Color>(Colors.red.shade900),
    fixedSize:MaterialStateProperty.all<Size>(Size.fromWidth(200)),
  ) ,);


Widget buidListProduct( model , context)=>Padding(
  padding: EdgeInsets.all(20),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              width: 100,
              height: 100,
              child: Image(image: NetworkImage('${model!.image}'),
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            if(model!.discount!=0)
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
        SizedBox(width: 10,),
        Expanded(child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model!.name}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    height:1.4
                ),
                maxLines: 2,
              ),
              Spacer(),
              Row(
                children: [
                  Text('${model!.price.toString()}',
                    style: TextStyle(
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(width: 10,),
                  if(model!.oldPrice !=0)
                    Text('${model!.oldPrice.toString()}',
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
                      ShopCubit.get(context).ChangeFavourites(model!.id!);
                    },
                    icon: CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favourites[model!.id]! ? Colors.red.shade900 : Colors.grey,
                      child: Icon(Icons.favorite_border_outlined, color: Colors.white,),
                    ),
                  )
                ],
              ),
            ],
          ),
        )),
      ],
    ),
  ),
);