import 'dart:convert';
import 'package:diceapp/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'question_screen.dart'; // Make sure to import the new screen

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> categoryData = [];
  List<Map<String, dynamic>> questionData = [];
  bool isloading=false;

  Future<void> loadData() async {
    try {
      final String response =
          await rootBundle.loadString('Asserts/Files/quiz.json');
      final List<dynamic> data = json.decode(response);

      setState(() {
        categoryData = data
            .map<String>((category) => category['category'] as String)
            .toList();
        questionData = data.cast<
            Map<String, dynamic>>(); // Cast the dynamic list to a list of maps
        isloading=false;
      });
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  void selectCategory(String category) {
    final List<Map<String, dynamic>> questions = questionData
        .firstWhere((element) => element['category'] == category)['questions']
        .cast<
            Map<String, dynamic>>(); // Cast the dynamic list to a list of maps

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            QuestionScreen(category: category, questions: questions),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {
      isloading=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffde4b4),
      // appBar: AppBar(
      //   title: Text('Quiz'),
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   // backgroundColor: Color(0xfffde4b4),
      // ),
      body: buildCategorySelection(),
    );
  }

  Widget buildCategorySelection() {
    return Container(
      // color: Color(0xfffde4b4),
      child: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          Container(
            height: 60,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Homepage();
                        },
                      ));
                    },
                    icon: Icon(Icons.keyboard_arrow_left),
                    style: ButtonStyle(
                        iconColor: WidgetStatePropertyAll(Colors.black),
                        iconSize: WidgetStatePropertyAll(25)),
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Quiz",
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child:isloading?Center(child: CircularProgressIndicator(),): ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: categoryData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => selectCategory(categoryData[index]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black,
                              blurRadius: 3,
                            ),
                          ],
                          color: Color(0xfffbbf50),
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Color(0xff966303), width: 3)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Text(
                          categoryData[index],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
