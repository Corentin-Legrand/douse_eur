import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:async';
import 'home_screen.dart';
import 'package:flutter/services.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.matrix(<double>[
                1.2, 0.1, 0.1, 0, 0,
                0.1, 1.2, 0.1, 0, 0,
                0.1, 0.1, 1.3, 0, 0,
                0, 0, 0, 1, 0,
              ]),
              child: Image.asset(
                "assets/images/background_animated.gif",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
              child: Container(
                color: Colors.black.withAlpha(12),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      double moveY = sin(_controller.value * 2 * pi) * 15;
                      double rotate = sin(_controller.value * 2 * pi) * 0.05;
                      double glitchOffset = sin(_controller.value * 8 * pi) * 3;

                      return Stack(
                        children: [
                          Transform.translate(
                            offset: Offset(-glitchOffset, moveY),
                            child: Transform.rotate(
                              angle: rotate,
                              origin: const Offset(100, 100),
                              child: const Text(
                                'Screen Breaker',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 200,
                                  color: Colors.red,
                                  fontFamily: 'Penstand',
                                ),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(glitchOffset, moveY),
                            child: Transform.rotate(
                              angle: -rotate,
                              origin: const Offset(100, 100),
                              child: const Text(
                                'Screen Breaker',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 200,
                                  color: Colors.cyan,
                                  fontFamily: 'Penstand',
                                ),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, moveY),
                            child: Transform.rotate(
                              angle: rotate / 2,
                              origin: const Offset(100, 100),
                              child: const Text(
                                'Screen Breaker',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 200,
                                  color: Colors.pink,
                                  fontFamily: 'Penstand',
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(title: 'Commencer le jeu'),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 150,
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/bouton_update.png'),
                        ),
                      ),
                      child: const Text(
                        'Commencer',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'terminal',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
