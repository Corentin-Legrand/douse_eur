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
      Item(name: 'Outil de clic +2', clicksRequired: 4, purchased: false, multiplier: 2),
      Item(name: 'Auto-Clicker', clicksRequired: 10, purchased: false, multiplier: 1),
      Item(name: 'Auto-Clicker Pro', clicksRequired: 20, purchased: false, multiplier: 1),
      Item(name: 'Auto-Clicker Max', clicksRequired: 30, purchased: false, multiplier: 1),
      Item(name: 'Auto-Clicker Ultra', clicksRequired: 40, purchased: false, multiplier: 1),
      Item(name: 'Auto-Clicker Supreme', clicksRequired: 50, purchased: false, multiplier: 1),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Vous avez cliqué ce nombre de fois :'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Text('Multiplicateur: x$_clickMultiplier', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 20),
            // Affichage de la boutique si activée
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bienvenue dans la boutique!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                            title: Text(item.name),
                            subtitle: Text('Clics requis: ${item.clicksRequired} clics'),
                            trailing: item.purchased
                                ? ElevatedButton(
                                    onPressed: () => _upgradeItemLevel(index),
                                    child: const Text('Passer au Niveau Suivant'),
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.shopping_cart, color: Colors.blue),
                                    onPressed: () => _buyItem(index),
                                  ),
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