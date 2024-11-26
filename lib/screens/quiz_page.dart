import 'package:flutter/material.dart';
import '../data/questions.dart';
import 'result_page.dart';
import 'feedback_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;

  void answerQuestion(int selectedIndex) {
    bool isCorrect = questions[currentQuestionIndex].correctAnswerIndex == selectedIndex;
    if (isCorrect) score++;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedbackPage(
          isCorrect: isCorrect,
          trivia: questions[currentQuestionIndex].trivia,
          onContinue: () {
            Navigator.pop(context);
            setState(() {
              currentQuestionIndex++;
            });
            if (currentQuestionIndex >= questions.length) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ResultPage(score: score)),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= questions.length) {
      return Container(); // Navigated to ResultPage
    }

    final question = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rap Lyrics Game',
          style: TextStyle(
            fontFamily: 'Bangers',
            fontSize: 28.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: currentQuestionIndex / questions.length,
              backgroundColor: Colors.grey[700],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
            const SizedBox(height: 30),
            Text(
              question.promptPrefix,
              style: TextStyle(
                fontFamily: 'Bangers',
                fontSize: 20.0,
                color: Colors.white70,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              question.lyric,
              style: TextStyle(
                fontFamily: 'Bangers',
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...question.options.asMap().entries.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: GestureDetector(
                  onTapDown: (_) => setState(() {}), // Button press effect
                  onTapUp: (_) => answerQuestion(option.key),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        option.value,
                        style: TextStyle(
                          fontFamily: 'Bangers',
                          fontSize: 20,
                          color: Colors.white,
                          letterSpacing: 1.1,
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
    );
  }
}
