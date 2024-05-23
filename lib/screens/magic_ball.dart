import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({super.key});

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('Idle');
  }

  void _onBallTapped() {
    setState(() {
      if (_controller.isActive) {
        _controller = SimpleAnimation('Screen on');
      } else {
        _controller = SimpleAnimation('Idle');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _onBallTapped,
          child: RiveAnimation.asset(
            'assets/magic_ball.riv',
            fit: BoxFit.cover,
            controllers: [_controller],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
