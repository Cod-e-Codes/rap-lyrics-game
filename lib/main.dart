import 'package:flutter/material.dart';
import 'screens/landing_page.dart';

void main() {
  runApp(const RapLyricsGame());
}

class RapLyricsGame extends StatelessWidget {
  const RapLyricsGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rap Lyrics Game',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Bangers', fontSize: 28),
          bodyMedium: TextStyle(fontFamily: 'Bangers', fontSize: 18),
        ),
        brightness: Brightness.dark,
      ),
      home: const LandingPage(),
      debugShowCheckedModeBanner: false, // Remove this line for production code.
    );
  }
}