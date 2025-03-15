class Item {
  final String name;
  final int clicksRequired;
  bool purchased;
  final int multiplier;

  Item({
    required this.name,
    required this.clicksRequired,
    this.purchased = false,
    required this.multiplier,
  });
}
