import 'package:flutter/material.dart';

class JellyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const JellyButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF57B9), Color(0xFFFD1D1D)], // Pink gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30), // High radius for pill shape
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.4),
              offset: const Offset(0, 8),
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Inner highlight effect for jelly look
            Positioned(
              top: 5,
              child: Container(
                width: 150,
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            // Button text
            Text(
              text,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Bangers',
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}