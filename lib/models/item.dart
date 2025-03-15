class Item {
  final String name;
  final int clicksRequired;
  bool purchased;
  final int multiplier;
  int level;

  Item({
    required this.name,
    required this.clicksRequired,
    this.purchased = false,
    required this.multiplier,
    this.level = 0,
  });

  int get auto => level * multiplier;
}