import 'dart:async';

class AutoClickerService {
  int _level = 0;
  double _interval = 2.0;
  final Function onCounterUpdated;

  AutoClickerService({required this.onCounterUpdated});

  int get level => _level;
  double get interval => _interval;

  Timer? _autoClickTimer;

  void startAutoClicker() {
    if (_autoClickTimer != null) {
      _autoClickTimer!.cancel(); // Annuler le timer précédent
    }

    _autoClickTimer = Timer.periodic(Duration(seconds: _interval.toInt()), (timer) {
      onCounterUpdated();
    });
  }

  void upgradeAutoClicker() {
    _level++;
    _interval = 2.0 / _level;
    if (_interval < 0.1) _interval = 0.1;
    startAutoClicker();
  }

  void dispose() {
    _autoClickTimer?.cancel();
  }
}
