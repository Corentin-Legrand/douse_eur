import 'package:flutter/material.dart';
import 'home_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // L'image en arrière-plan
          Positioned.fill(
            child: Image.asset(
              "assets/images/fond_ecran_principal.jpg",
              fit: BoxFit.cover, // L'image couvre toute la surface
            ),
          ),
          // Le contenu (texte et bouton) centré par-dessus l'image
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0), // Décaler vers le haut
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Aligner le contenu vers le haut
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container( // Espace autour du texte
                    child: const Text(
                      'Screen Breaker',
                      style: TextStyle(fontSize: 200, color: Colors.pink, fontFamily: 'Penstand'),
                    ),
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
                      width: 200, // Largeur du bouton
                      height: 150,
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0), // Ajouter du padding
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
                          color: Colors.white, // Le texte en blanc
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
