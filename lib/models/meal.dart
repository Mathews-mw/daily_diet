import 'dart:math';

class Meal {
  String id = Random().nextDouble().toString();
  final String name;
  final String description;
  final bool isDiet;
  final DateTime registerAt;

  Meal({
    required this.name,
    required this.description,
    required this.registerAt,
    required this.isDiet,
  });
}
