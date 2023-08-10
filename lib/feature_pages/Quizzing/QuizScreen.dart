import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import '../../gpt_integration/api_service.dart';
import 'QuestionModel.dart';
import 'package:note_wiz/globals.dart' as globals;

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade900,
       appBar: AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      title: Text("Quiz", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
    ),
       body:
       Container(
       decoration: BoxDecoration(
       gradient: LinearGradient(
    colors: [
    Colors.deepPurpleAccent,
    Colors.deepPurple.shade100,
    ],
    begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    )
    ),
         child: ListView(
           scrollDirection: Axis.vertical,
           children: [
             Container(
                 margin: const EdgeInsets.all(20),
                 child: FutureBuilder<List<Question>>(
                     future: getQuiz(globals.lectureTranscript),
                     builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
                       TextSpan children;
                       if (snapshot.hasData) {
                         questionList = snapshot.data!;
                         print("hiiiiiii rhea");
                       } else {
                         print("meow ur mom"); // TODO - loading symbol
                       }
                       return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                         const SizedBox(height: 8),
                         _questionWidget(),
                         const SizedBox(height: 32),
                         _answerList(),
                         const SizedBox(height: 32),
                         _nextButton(),
                       ]);
                     }
                 )
             ),
           ],
         ),
       ),
        //Container(
      //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      //   child:
      //     Text(""),
      //   // Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      //   //   const SizedBox(height: 8),
      //   //   _questionWidget(),
      //   //   _answerList(),
      //   //   _nextButton(),
      //   // ]),
      // ),
    );
  }

  Future<List<Question>> getQuiz(String lectureTranscript) async {
    var numQuestions = 3;
    print("point 0");
    var quizResponse = await ApiService.sendMessage(message: '''Compose a quiz referencing only the following text. The objective is to create an AI-generated quiz that has the same depth and difficulty as a human-made quiz. 
        Format the quiz questions like the following:
        1.  [Question]
        a. [Answer Choice 1]
        b. [Answer Choice 2]
        c. [Answer Choice 3]
        d. [Answer Choice 4]
        Make it a $numQuestions question quiz. Put the answers to the $numQuestions questions at the bottom of the quiz in a 5 character long word. Make the questions hard to answer.   $lectureTranscript''', modelId: 'gpt-3.5-turbo');
    if (quizResponse[quizResponse.length-1].msg == null) {
      print("point 1999");
      return [];
    } else {
      String response = quizResponse[quizResponse.length-1].msg!;
      print("response $response");
      List<Question> questions = [];
      LineSplitter ls = LineSplitter();
      List<String> lines = ls.convert(response);

      for (int i = 0; i < numQuestions; i++) {
        print("iteration $i");
        List<String> questionAsList = [];
        for (int j = 0; j < 5; j++) { // 1 q + 4 answers = 5 iterations
          questionAsList.add(lines[j].substring(2).trim());
        }
        print("point 2. $questionAsList");
        questions.add(Question(questionAsList[0], [
          Answer(questionAsList[1], false),
          Answer(questionAsList[2], false),
          Answer(questionAsList[3], false),
          Answer(questionAsList[4], false)
        ]));
        print("$i: questions: $questions");
        lines.removeRange(0, 6);
        print("lines $lines");
      }

      if (!lines[0].contains(". ")) {
        lines.removeAt(0);
      }

      print("6000000 $lines");

      for (int i = 0; i < numQuestions; i++) {
        int correctAns = 0;
        if (lines[i][3].toLowerCase().trim() == "b") {
          correctAns = 1;
        }
        else if (lines[i][3].toLowerCase().trim() == "c") {
          correctAns = 2;
        }
        else if (lines[i][3].toLowerCase().trim() == "d") {
          correctAns = 3;
        }

        questions[i].answersList[correctAns].isCorrect = true;
      }
      print("point 4. $questions");
      return questions;
    }


  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Question ${currentQuestionIndex + 1}/${questionList.length.toString()}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade400,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map(
            (e) => _answerButton(e),
      )
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(answer.answerText),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected ? Colors.blueAccent : Colors.deepPurple.shade100,
          onPrimary: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          if (selectedAnswer == null) {
            if (answer.isCorrect) {
              score++;
            }
            setState(() {
              selectedAnswer = answer;
            });
          }
        },
      ),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
        child: Text(isLastQuestion ? "Submit" : "Next"),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.white,
          onPrimary: Colors.black,
        ),
        onPressed: () {
          if (isLastQuestion) {
            //display score

            showDialog(context: context, builder: (_) => _showScoreDialog());
          } else {
            //next question
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
            });
          }
        },
      ),
    );
  }

  _showScoreDialog() {
    bool isPassed = false;

    if (score >= questionList.length * 0.6) {
      //pass if 60 %
      isPassed = true;
    }
    String title = isPassed ? "Passed " : "Failed";

    return AlertDialog(
      title: Text(
        title + " | Score is $score",
        style: TextStyle(color: isPassed ? Colors.green : Colors.redAccent),
      ),
      content: ElevatedButton(
        child: const Text("Restart"),
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            currentQuestionIndex = 0;
            score = 0;
            selectedAnswer = null;
          });
        },
      ),
    );
  }
}