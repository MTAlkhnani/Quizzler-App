import 'package:flutter/material.dart';
import 'package:flutter_application_1/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  List<Widget> icons = [];
  QuizBrain quizBrain = QuizBrain();
  //int qLen = quizBrain.getLength();

  void checkAnswer(bool userAns) {
    setState(() {
      if (quizBrain.getAnswer() == userAns) {
        score++;
        icons.add(const Icon(Icons.check, color: Colors.green));
      } else {
        icons.add(const Icon(Icons.close, color: Colors.red));
      }
      print(score);
    });
  }

  void resetQuiz() {
    quizBrain.resetQ();
    icons.clear();
    score = 0;
  }

  // _onBasicAlertPressed(context) {
  //   Alert(
  //     context: context,
  //     title: "Warning: Qustions limit reached",
  //     desc: "Questions will reset",
  //   ).show();
  // }
  void showAlert() {
    Alert(
      context: context,
      title: "QUIZ COMPLETED",
      desc: "You have completed the quiz.\n"
          "The quiz will now reset.",
      type: AlertType.success,
      buttons: [
        DialogButton(
          child: const Text(
            "ok",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            'Score: $score/${quizBrain.getLength()}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            'Question: ${quizBrain.getQNum() + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: Text(
              quizBrain.getQuestionText(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (quizBrain.getQNum() < quizBrain.getLength() - 1) {
                    checkAnswer(true);
                    quizBrain.nextQuestion();
                  } else {
                    showAlert();
                    resetQuiz();
                  }
                });
              },
              child: Container(
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (quizBrain.getQNum() < quizBrain.getLength() - 1) {
                    checkAnswer(false);
                    quizBrain.nextQuestion();
                  } else {
                    showAlert();
                    resetQuiz();
                  }
                });
              },
              child: Container(
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'False',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: icons,
        ),
      ],
    );
  }
}
