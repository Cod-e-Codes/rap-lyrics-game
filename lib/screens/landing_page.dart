import 'package:flutter/material.dart';
import '../widgets/jelly_button.dart';
import '../screens/quiz_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  void startQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuizPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rap Lyrics Game',
                  style: TextStyle(
                    fontFamily: 'Bangers',
                    fontSize: 48.0,
                    color: Colors.yellowAccent,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Test your knowledge of iconic rap lyrics! Are you ready to prove you\'re a rap legend?',
                  style: TextStyle(
                    fontFamily: 'Bangers',
                    fontSize: 20.0,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                JellyButton(
                  onPressed: () => startQuiz(context),
                  text: 'Start Quiz',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}