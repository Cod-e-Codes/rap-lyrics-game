import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import '../widgets/jelly_button.dart';

class FeedbackPage extends StatefulWidget {
  final bool isCorrect;
  final String trivia;
  final VoidCallback onContinue;

  const FeedbackPage({
    super.key,
    required this.isCorrect,
    required this.trivia,
    required this.onContinue,
  });

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> with SingleTickerProviderStateMixin {
  final confettiController = ConfettiController(duration: const Duration(seconds: 2));
  final audioPlayer = AudioPlayer();
  bool _showTrivia = false;
  late AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    if (widget.isCorrect) {
      confettiController.play();
      audioPlayer.play(AssetSource('correct.mp3'));
    } else {
      audioPlayer.play(AssetSource('incorrect.mp3'));
    }

    // Trigger trivia box animation after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showTrivia = true;
      });
    });
  }

  @override
  void dispose() {
    confettiController.dispose();
    audioPlayer.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.isCorrect
                ? [Colors.green.shade700, Colors.green.shade400]
                : [Colors.red.shade700, Colors.red.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: Tween(begin: 0.9, end: 1.1)
                        .animate(CurvedAnimation(parent: _iconAnimationController, curve: Curves.easeInOut)),
                    child: Icon(
                      widget.isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.isCorrect ? 'Correct!' : 'Wrong Answer!',
                    style: TextStyle(fontFamily: 'Bangers', fontSize: 36, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: _showTrivia ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedScale(
                      scale: _showTrivia ? 1.0 : 0.8,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutBack,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black87, Colors.black54],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                          border: Border.all(color: Colors.white.withOpacity(0.6), width: 2),
                        ),
                        child: Text(
                          widget.trivia,
                          style: const TextStyle(fontSize: 18, color: Colors.white, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  JellyButton(
                    onPressed: widget.onContinue,
                    text: 'Continue',
                  ),
                ],
              ),
            ),
            if (widget.isCorrect)
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirection: -3.14 / 2,
                  emissionFrequency: 0.1,
                  numberOfParticles: 20,
                  gravity: 0.3,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
