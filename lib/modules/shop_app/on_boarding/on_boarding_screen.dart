import 'package:flutter/material.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    this.image,
    this.title,
    this.body,
  });
}

class OnBoardingScreen extends StatelessWidget {

var boardController = PageController();

List<BoardingModel> boarding = [
  BoardingModel(
    image: 'assets/images/onBiard1.jpg',
    title: 'On Board 1 Title',
    body: 'On Board 1 Body',
  ),
  BoardingModel(
    image: 'assets/images/onBiard1.jpg',
    title: 'On Board 2 Title',
    body: 'On Board 2 Body',
  ),
  BoardingModel(
    image: 'assets/images/onBiard1.jpg',
    title: 'On Board 3 Title',
    body: 'On Board 3 Body',
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OnBoard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,),
            Row(
              children: [
                Text(
                  'Indicator',
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  boardController.nextPage(
                    duration: Duration(milliseconds: 750), 
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                },
                child: Icon(Icons.arrow_forward_ios),)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
