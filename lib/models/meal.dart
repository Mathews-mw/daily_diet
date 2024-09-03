import 'dart:math';

class Meal {
  String id = Random().nextDouble().toString();
  final String name;
  final bool isDiet;
  final DateTime registerAt;

  Meal({
    required this.name,
    required this.registerAt,
    required this.isDiet,
  });
}
