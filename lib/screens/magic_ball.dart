import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MagicBallScreen extends StatelessWidget {
  const MagicBallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/magic_ball.riv',
        ),
      ),
    );
  }
}
