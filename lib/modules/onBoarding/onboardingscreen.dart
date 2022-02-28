import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/modules/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoardingModel {
  final String image;
  final String titleText;
  final String bodyText;

  OnBoardingModel({
    required this.image,
    required this.titleText,
    required this.bodyText,
  });
}
class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast=false;
  var pageController = PageController();
  List<OnBoardingModel> onBoard=[
  OnBoardingModel(
  image:'assets/images/onboarding1.jpg',
  bodyText: 'shop 1 body',
  titleText:'shop 1 title' ,

  ),
  OnBoardingModel(
  image:'assets/images/onboarding2.jpg',
  bodyText: 'shop 2 body',
  titleText:'shop 2 title' ,

  ),
  OnBoardingModel(
  image:'assets/images/onboarding3.jpg',
  bodyText: 'shop 3 body',
  titleText:'shop 3 title' ,

  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>ShopLoginScreen()));
              }, child:Text('Skip',
            style: TextStyle(
              color: Colors.red.shade900,
            ),
          )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child:PageView.builder(
                controller: pageController,
                physics:BouncingScrollPhysics(),
                onPageChanged: (int index){
                  if(index==onBoard.length-1){
                    setState(() {
                      isLast=true;
                      print(' Last');
                    });
                  }else {
                    setState(() {
                      isLast = false;
                      print('not Last');
                    });
                  }
                },
                itemBuilder: (context,index)=>buildSreenItem(onBoard[index]),
                itemCount: onBoard.length,),),
            SizedBox(height: 100,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageController,
                    count: onBoard.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.red.shade900,
                      dotHeight: 15,
                      expansionFactor: 4,
                      dotWidth: 15,
                      spacing: 5,
                    )
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast==true){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopLoginScreen()));
                    }else{
                      pageController.nextPage(
                          duration: Duration(
                            microseconds: 750,
                          ),
                          curve:Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),backgroundColor: Colors.red.shade900,)
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget buildSreenItem(OnBoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child:Image(
        image: AssetImage('${model.image}'),
      ),),

      Text('${model.titleText}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
          fontFamily:'candy',
        ),),
      SizedBox(height: 15,),
      Text('${model.bodyText}',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),),
    ],
  );
}

