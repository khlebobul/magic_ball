import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({super.key});

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/magic_ball.riv',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
