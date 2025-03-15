import 'dart:async';

import 'package:flutter/material.dart';
import '../models/item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _clickMultiplier = 1.0;
  bool _isShopVisible = false;
  late List<Item> _items;
  late Timer _timer;

  int get autoClickerCount => _items
      .where((item) => item.name.contains('Auto-Clicker'))
      .fold(0, (sum, item) => sum + item.level * item.multiplier);



  @override
  void initState() {
    super.initState();
    _items = [
      Item(name: 'Marteau', clicksRequired: 4, purchased: false, multiplier: 1),
      Item(name: 'Hooligan', clicksRequired: 10, purchased: false, multiplier: 1),
      Item(name: 'Duo Hooligans', clicksRequired: 20, purchased: false, multiplier: 2),
      Item(name: 'Bande de Hooligans', clicksRequired: 30, purchased: false, multiplier: 3),
      Item(name: 'Groupe de Hooligans', clicksRequired: 40, purchased: false, multiplier: 6),
      Item(name: 'Stade de Hooligans', clicksRequired: 50, purchased: false, multiplier: 14),
    ];

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCounter(autoClickerCount.toDouble());
    });
  }

  void _updateCounter(double scoreMultiplier) {
    setState(() {
      _counter += scoreMultiplier.toInt();
    });
  }


  void _incrementCounter() {
    setState(() {
      _counter += _clickMultiplier.toInt();
    });
  }

  void _buyItem(int index) {
    setState(() {
      final item = _items[index];
      if (_counter >= item.clicksRequired ) {
        _counter -= item.clicksRequired;
        item.level++;
        item.purchased = true;

        if (item.name.contains('Auto-Clicker')) {
          // Update auto-clicker logic if needed
        } else {
          _clickMultiplier += item.multiplier;
        }
      }
    });
  }

  void _toggleShopVisibility() {
    setState(() {
      _isShopVisible = !_isShopVisible;
    });
  }

  void _upgradeItemLevel(int index) {
    setState(() {
      final item = _items[index];
      if (_counter >= item.clicksRequired) {
        _counter -= item.clicksRequired;
        item.level++;
        if (item.name.contains('Auto-Clicker')) {
        } else {
          _clickMultiplier += item.multiplier;
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Premier groupe avec l'image de fond
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fond_ecran_principal.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Morceaux de verres possédés',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        fontFamily: 'terminal'
                      ),
                    ),
                    Image.asset("assets/images/eclat_de_verre.png", height: 75, width: 75, fit: BoxFit.contain),
                    const SizedBox(height : 20),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontFamily: 'Penstand'),
                    ),
                    const SizedBox(height: 60),
                    Text(
                      'Multiplicateur: x$_clickMultiplier',
                      style: const TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'terminal'),
                    ),
                    const SizedBox(height: 60),
                    InkWell(
                      onTap: _incrementCounter,
                      splashColor: Colors.blue.withOpacity(0.5), // Couleur de l'effet de splash
                      highlightColor: Colors.blue.withOpacity(0.3), // Couleur quand pressé
                      borderRadius: BorderRadius.circular(50), // Pour un effet rond
                      child: Image.asset(
                        'assets/images/EC.png',
                        width: 100,
                        height: 100,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Deuxième groupe sans image de fond (exemple de boutique)
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fond_ecran_secondaire.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      'Bienvenue dans la boutique!',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'terminal',
                          color: Colors.pink
                      ),
                    selectionColor: Colors.pink,
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                              item.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'terminal',
                                fontSize: 25
                              ),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                '${item.clicksRequired} ',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontFamily: 'terminal',
                                  fontSize: 23,
                                ),
                              ),
                              Image.asset(
                                'assets/images/eclat_de_verre.png', // Remplace par l'image que tu veux
                                width: 24,  // Ajuste la taille de l'image
                                height: 24, // Ajuste la taille de l'image
                              ),
                            ],
                          ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}