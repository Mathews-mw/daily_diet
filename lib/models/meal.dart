import 'dart:math';

class Meal {
  final String _id = Random().nextDouble().toString();
  String _name;
  String _description;
  bool _isDiet;
  DateTime _registerAt;

  Meal({
    required name,
    required description,
    required registerAt,
    required isDiet,
  })  : _name = name,
        _description = description,
        _isDiet = isDiet,
        _registerAt = registerAt;

  String get id => _id;

  String get name => _name;

  set name(String newName) {
    _name = newName;
  }

  String get description => _description;

  set description(String newDescription) {
    _description = newDescription;
  }

  bool get isDiet => _isDiet;

  set isDiet(bool value) {
    _isDiet = value;
  }

  DateTime get registerAt => _registerAt;

  set registerAt(DateTime newDate) {
    _registerAt = newDate;
  }
}
