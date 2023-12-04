class Answer {
  final String id;
  final tagIds = [];

  String text;

  static Answer fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] as String,
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }

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

  static Player fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Rule {
  final String id;
  final String text;

  Rule({
    required this.id,
    required this.text,
  });

  static Rule fromJson(Map<String, dynamic> json) {
    return Rule(
      id: json['id'] as String,
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }
}
