import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: const SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: QuizPage(),
              ),
            )));
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  late String errorMessage;

  void handleButtonAnswer(bool answer) {
    if (quizBrain.isFinished() == true) {
      print('ALERT');
      Alert(
        context: context,
        title: 'Finished!',
        desc: 'You\'ve reached the end of the quiz.',
      ).show();
      quizBrain.reset();
      setState(() {
        scoreKeeper = [];
      });
    } else {
      bool correctAnswer = quizBrain.getQuestionAnswer();
      if (answer == correctAnswer) {
        setState(() {
          scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
        });
      } else {
        setState(() {
          scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
        });
      }
      quizBrain.nextQuestion();
    }
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
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                    backgroundColor: Colors.green),
                onPressed: () {
                  handleButtonAnswer(true);
                },
                child: const Text(
                  'True',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                )),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  handleButtonAnswer(false);
                },
                child: const Text(
                  'False',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                )),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
