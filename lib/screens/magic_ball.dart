import 'package:flutter/material.dart';
import 'package:magic_ball/api/api_client.dart';
import 'package:rive/rive.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({super.key});

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  late RiveAnimationController _controller;
  String _responseText = '';
  bool _isLoading = false;
  final ApiClient _apiClient = ApiClient(); // Инициализируем API клиент

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('Idle');
  }

  Future<void> _fetch8BallResponse() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final responseText = await _apiClient.fetch8BallResponse();
      setState(() {
        _responseText = responseText;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _responseText = 'Error fetching response';
        _isLoading = false;
      });
    }
  }

  void _onBallTapped() {
    setState(() {
      if (_controller.isActive) {
        _controller = SimpleAnimation('Screen on');
        _fetch8BallResponse();
      } else {
        _controller = SimpleAnimation('Idle');
        _responseText = '';
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
          if (_responseText.isNotEmpty)
            Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      _responseText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
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
