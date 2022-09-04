import 'package:e_commerce/login/login.dart';
import 'package:e_commerce/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/cache_helper.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
  required this.image,
    required this.title,
    required this.body,
});
}



class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   var boardController = PageController();

List<BoardingModel> boarding=[
  BoardingModel(
      image: 'assets/images/onBoarding.png',
      title: 'On Board 1 title',
      body: 'On Board 1 body'
  ),
  BoardingModel(
      image: 'assets/images/onBoarding.png',
      title: 'On Board 2 title',
      body: 'On Board 2 body'
  ),
  BoardingModel(
      image: 'assets/images/onBoarding.png',
      title: 'On Board 3 title',
      body: 'On Board 3 body'
  )
];
bool isLast = false;
void submit(){
CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
  if(value){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder:
              (context)=>Login()),
          (Route<dynamic> route) =>false,
    );
  }
});

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          TextButton(
              onPressed: (){
             submit();
    },
              child: Text(
            'SKIP',
                style: TextStyle(
                  color: Colors.deepOrange,
                ),
          ))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
         children: [
           Expanded(
             child: PageView.builder(
               physics: BouncingScrollPhysics(),
               controller: boardController,
               onPageChanged: (int index){
                 if(index==boarding.length-1){
                   setState(() {
                     isLast=true;
                   });
                 }else{
                   setState(() {
                     isLast=false;
                   });
                 }
               },
               itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
             itemCount: boarding.length,),
           ),
           SizedBox(
             height: 40.0,
           ),
           Row(
             children: [

               SmoothPageIndicator(
                   controller: boardController,
                   effect: ExpandingDotsEffect(
                     dotColor: Colors.grey,
                     activeDotColor: defaultColors,
                     dotHeight: 10.0,
                     expansionFactor: 4,
                     dotWidth: 10.0,
                     spacing: 5,
                   ),
                   count: boarding.length),
               Spacer(),
               FloatingActionButton(onPressed: (){
                 if(isLast){
                  submit();
                 }else
                 {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
               child: Icon(
                 Icons.arrow_forward_ios
               ),
               )
             ],
           )
         ],
        ),
      )
    );
  }
}
Widget buildBoardingItem( BoardingModel model)=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage(model.image),
      ),
    ),

    Text(
      model.title,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(
      height: 15.0,
    ),
    Text(
        model.body,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        )
    ),
    SizedBox(
      height: 15.0,
    ),
  ],
) ;
