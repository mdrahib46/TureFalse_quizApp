import 'package:flutter/material.dart';
import "package:rflutter_alert/rflutter_alert.dart";
import 'quiz_Brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade800,
          centerTitle: true,
          title: Text(
            'Quize App',
            style: (TextStyle(fontSize: 25.0, letterSpacing: 4.0)),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizePage(),
          ),
        ),
      ),
    );
  }
}

class QuizePage extends StatefulWidget {
  const QuizePage({Key? key}) : super(key: key);

  @override
  State<QuizePage> createState() => _QuizePageState();
}

class _QuizePageState extends State<QuizePage> {
  // This List contain some scores values of icon
  List<Icon> scoreKeeper = [];

  void checkAns(bool userpickedans){
    bool correctAns = quizBrain.GetCorrectAns();

    if (userpickedans ==  correctAns){
      print("Your are right !");
      scoreKeeper.add(Icon(Icons.check, color: Colors.green, size: 25,),);

    }else{
      print("you are wrong !");
      scoreKeeper.add(Icon(Icons.close, color: Colors.red, size: 25),);
    }
    setState(() {
      if(quizBrain.isfinished() == true){
        Alert(
          context: context,
          type: AlertType.success,
          desc: 'You have reached end of the quize !',

        ).show();

        quizBrain.reset();
        scoreKeeper = [];
      }

      quizBrain.nxtQue();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.GetQueTxt(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SizedBox(
              height: 80.0,
              width: double.maxFinite,
              child: TextButton(
                  onPressed: () {
                    checkAns(true);
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  child: Text(
                    'True',
                    style: TextStyle(fontSize: 25.0, color: Colors.white, letterSpacing: 3.0),
                  ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SizedBox(
              height: 80.0,
              width: double.maxFinite,
              child: TextButton(
                onPressed: () {
                  checkAns(false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  'False',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    letterSpacing: 3.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}



