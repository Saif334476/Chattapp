import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedChatBubble extends StatefulWidget {
  @override
  _AnimatedChatBubbleState createState() => _AnimatedChatBubbleState();
}

class _AnimatedChatBubbleState extends State<AnimatedChatBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int dotCount = 1; // Start with 1 dot
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Smooth scale animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Slower scaling
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Timer to update dots every **600ms** (slower than before)
    _timer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      setState(() {
        dotCount = (dotCount % 3) + 1; // Cycle through 1 → 2 → 3 dots
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel(); // Stop the timer when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFF2074B5), // Primary theme color
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.chat_bubble, color: Colors.white, size: 22),
            const SizedBox(width: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400), // Smooth switch
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Text(
                "." * dotCount, // Dynamically update dots
                key: ValueKey<int>(dotCount),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
