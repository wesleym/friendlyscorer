class Answer {
  final String id;
  final tagIds = [];

  String text;

  Answer({
    required this.id,
    required this.text,
  });
}

class Player {
  final String id;
  final String name;

  Player({
    required this.id,
    required this.name,
  });
}

class Rule {
  final String id;
  final String text;

  Rule({
    required this.id,
    required this.text,
  });
}
