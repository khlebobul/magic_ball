import 'dart:async';
import 'package:flutter/material.dart';
import 'package:magic_ball/api/api_client.dart';
import 'package:rive/rive.dart';

const String kIdleAnimation = 'Idle';
const String kActiveAnimation = 'Screen on';
const String kLoadingErrorText = 'Error fetching response';
const double kTextFontSize = 18.0;
const Color kTextColor = Colors.white;
const Duration kOpacityAnimationDuration = Duration(milliseconds: 500);
const Duration kTextDisplayDelay = Duration(milliseconds: 200);
const riveAnimationAssetPath = 'assets/magic_ball.riv';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({super.key});

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  late RiveAnimationController _controller;
  String _responseText = '';
  bool _isLoading = false;
  bool _showText = false;
  final ApiClient _apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation(kIdleAnimation);
  }

  Future<void> _fetch8BallResponse() async {
    setState(() {
      _isLoading = true;
      _showText = false;
    });

    try {
      final responseText = await _apiClient.fetch8BallResponse();
      setState(() {
        _responseText = responseText;
        _isLoading = false;
      });

      Future.delayed(kTextDisplayDelay, () {
        setState(() {
          _showText = true;
        });
      });
    } catch (e) {
      setState(() {
        _responseText = kLoadingErrorText;
        _isLoading = false;
        _showText = true;
      });
    }
  }

  void _onBallTapped() {
    setState(() {
      if (_controller.isActive) {
        _controller = SimpleAnimation(kActiveAnimation);
        _fetch8BallResponse();
      } else {
        _controller = SimpleAnimation(kIdleAnimation);
        _responseText = '';
        _showText = false;
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
                riveAnimationAssetPath,
                fit: BoxFit.cover,
                controllers: [_controller],
              ),
            ),
          ),
          Center(
            child: _isLoading
                ? const CircularProgressIndicator()
                : AnimatedOpacity(
                    opacity: _showText ? 1.0 : 0.0,
                    duration: kOpacityAnimationDuration,
                    child: Text(
                      _responseText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: kTextFontSize,
                        color: kTextColor,
                      ),
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
