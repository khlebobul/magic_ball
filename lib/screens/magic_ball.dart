import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({super.key});

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  late RiveAnimationController _controller;
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('Idle');
  }

  void _onBallTapped() {
    setState(() {
      if (_controller.isActive) {
        _controller = SimpleAnimation('Screen on');
        _showText = true; // Show text when animation is active
      } else {
        _controller = SimpleAnimation('Idle');
        _showText = false; // Hide text when animation is idle
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: _onBallTapped,
              child: RiveAnimation.asset(
                'assets/magic_ball.riv',
                fit: BoxFit.cover,
                controllers: [_controller],
              ),
            ),
          ),
          if (_showText)
            const Center(
              child: Text(
                'Active',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
