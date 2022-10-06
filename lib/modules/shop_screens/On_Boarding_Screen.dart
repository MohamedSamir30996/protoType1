import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_start/modules/shop_screens/Login_Screen/Shop_Login_Screen.dart';
import 'package:udemy_start/shared/components/components.dart';
import 'package:udemy_start/shared/network/local/Cache_Helper.dart';
import 'package:udemy_start/shared/styles/colors.dart';

class BoardingModel {
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

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'Assets/Images/onboard_1.jpg',
      title: "On Board Title 1",
      body: "Body 1",
    ),
    BoardingModel(
      image: 'Assets/Images/onboard_1.jpg',
      title: "On Board Title 2",
      body: "Body 2",
    ),
    BoardingModel(
      image: 'Assets/Images/onboard_1.jpg',
      title: "On Board Title 3",
      body: "Body 3",
    ),
  ];

  bool isLast = false;

  void submit()
  {
    CacheHelper.SaveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        NavigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();
          }, child: Text(
            'SKIP',
          ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
              controller: boardController,
              itemBuilder: (context, index) => BoardingItemBuilder(boarding[index]),
              itemCount: boarding.length,
              physics: BouncingScrollPhysics(),
              onPageChanged: (index){
                if(index == boarding.length - 1){
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    spacing: 5,
                    dotHeight: 16,
                    dotWidth: 16,
                    expansionFactor: 1.01,
                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast){
                    submit();
                  }else{
                    boardController.nextPage(
                      duration: Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.bounceInOut,
                    );
                  }
                },
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }


  Widget BoardingItemBuilder(BoardingModel model) => Column(
    children: [
      Expanded(
          child: Image(image: AssetImage('${model.image}'))),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 22,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      SizedBox(
        height: 40,
      ),
    ],
  );
}
