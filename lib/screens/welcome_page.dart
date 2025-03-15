import 'package:flutter/material.dart';
import 'dart:math';
import 'home_screen.dart';

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
      duration: const Duration(seconds: 7),
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
          // L'image en arrière-plan
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_animated.gif",
              fit: BoxFit.cover, // L'image couvre toute la surface
            ),
          ),
          // Le contenu (texte et bouton) centré par-dessus l'image
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0), // Décaler vers le haut
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      double moveY = sin(_controller.value * 2 * pi) * 20;
                      double rotate = sin(_controller.value * 2 * pi) * 0.05;

                      return Transform.translate(
                        offset: Offset(0, moveY),
                        child: Transform.rotate(
                          angle: rotate,
                          origin: const Offset(100, 100), // Centre de rotation
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
                      alignment: Alignment.center, // Centrer le texte
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
