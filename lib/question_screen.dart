import 'dart:async';
import 'dart:ui';

import 'package:diceapp/Quiz.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuestionScreen extends StatefulWidget {
  final String category;
  final List<Map<String, dynamic>> questions;

  const QuestionScreen(
      {required this.category, required this.questions, Key? key})
      : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool result = false;
  Map<String, dynamic>? currentQuestion;
  String? selectedAnswer;

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          width: 800,
          child: AlertDialog(
            backgroundColor: Color(0xfffde4b4),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Quiz();
                          },
                        ));
                      },
                      icon: Icon(Icons.close),
                      color: Colors.black,
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("Asserts/congratulation.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Congrats!",
                  style: TextStyle(
                      color: Color(0xff080c0d),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      letterSpacing: 2,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),
                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 10.0,
                  animation: true,
                  percent: score / widget.questions.length,
                  center: Text(
                    "${((score / widget.questions.length) * 100).toInt()}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: result ? Colors.green : Colors.red,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Color(0xfffbbf50),
                  backgroundColor: Colors.grey,
                ),
                SizedBox(height: 10),
                Text(
                  "Your score is ${score.toString()}/${widget.questions.length}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: result ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    currentQuestion = widget.questions[currentQuestionIndex];
  }

  void nextQuestion() {
    setState(() {
      currentQuestionIndex++;
      selectedAnswer = null;
      if (currentQuestionIndex < widget.questions.length) {
        currentQuestion = widget.questions[currentQuestionIndex];
      } else {
        result = score >= (widget.questions.length / 2);
        showResultDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffde4b4),
        title: Text(widget.category, style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        color: Color(0xfffde4b4),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                minHeight: 15,
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
                value: currentQuestionIndex / widget.questions.length,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Color(0xff7d5203), width: 4)),
                  color: Color(0xfffbbf50),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Question ${currentQuestionIndex + 1} /${widget.questions.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            color: Colors.black,
                            height: 3,
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(currentQuestion!['question'],
                                style: TextStyle(
                                    fontSize: 23, color: Colors.black)),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Column(
                            children: [
                              ...List.generate(
                                  currentQuestion!['options'].length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedAnswer =
                                          currentQuestion!['options'][index];
                                      if (selectedAnswer ==
                                          currentQuestion!['answer']) {
                                        score++;
                                      }
                                    });
                                    Timer(Duration(seconds: 2), () {
                                      nextQuestion();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:  selectedAnswer != null
                                            ? (currentQuestion!['options']
                                        [index] ==
                                            currentQuestion!['answer']
                                            ? Colors.lightGreen
                                            : Color(0xffff6666)):Color(0xfffddb9b),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: selectedAnswer != null
                                              ? (currentQuestion!['options']
                                                          [index] ==
                                                      currentQuestion!['answer']
                                                  ? Colors.green
                                                  : Colors.red)
                                              : Color(0xff966303),
                                          width: 3,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Center(
                                          child: Text(
                                            currentQuestion!['options'][index],
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
