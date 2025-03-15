import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/auto_clicker_service.dart';

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
  int _autoClickerUpgradePrice = 10;

  late AutoClickerService _autoClickerService;
  late List<Item> _items;

  @override
  void initState() {
    super.initState();
    _autoClickerService = AutoClickerService(onCounterUpdated: _updateCounter);
    _items = [
      Item(name: 'Outil de clic +2', clicksRequired: 4, purchased: false, multiplier: 2),
      Item(name: 'Auto-Clicker', clicksRequired: 10, purchased: false, multiplier: 1),
    ];
    final player = AudioPlayer();
    void playMusic() async {
      await player.play(AssetSource('audio/background_song.mp3'), volume: 0.1);
    }
    playMusic();
  }



  void _updateCounter() {
    setState(() {
      _counter += 1;
    });
  }

  void _incrementCounter() {
    final player = AudioPlayer();
    void playMusic() async {
      await player.play(AssetSource('audio/click.mp3'));
    }
    playMusic();
    setState(() {
      _counter += _clickMultiplier.toInt();
    });
  }

  void _buyItem(int index) {
    setState(() {
      if (_counter >= _items[index].clicksRequired && !_items[index].purchased) {
        _counter -= _items[index].clicksRequired;
        _items[index].purchased = true;

        if (index == 1) {
          // Améliorer l'auto-clicker si c'est l'item "Auto-Clicker"
          _autoClickerService.upgradeAutoClicker();
        } else {
          _clickMultiplier += _items[index].multiplier;
        }
      }
    });
  }

  void _toggleShopVisibility() {
    setState(() {
      _isShopVisible = !_isShopVisible;
    });
  }

  @override
  void dispose() {
    _autoClickerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.shop),
            onPressed: _toggleShopVisibility,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Vous avez cliqué ce nombre de fois :'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Text('Multiplicateur: x$_clickMultiplier', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text(
              'Auto-Clicker: Niveau ${_autoClickerService.level} (Intervalle: ${_autoClickerService.interval.toStringAsFixed(2)} secondes)\nAméliorer pour $_autoClickerUpgradePrice clics',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 40),
            if (_isShopVisible)
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
                                ? IconButton(
                                    icon: const Icon(Icons.check_circle, color: Colors.green),
                                    onPressed: null,
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
