import 'package:flutter/widgets.dart';

class Answer {
  final String id;
  final tagIds = [];

  String text;

  Answer({
    required this.id,
    this.text = '',
  });
}

class Player {
  final String id;
  final String name;
  Color color;

  Player({
    required this.id,
    required this.name,
    required this.color,
  });
}

class Tag {
  final String id;

  Tag({required this.id});
}
