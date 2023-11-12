class Answer {
  final String id;
  final tagIds = [];
  final authorIds = [];

  String text;

  Answer({
    required this.id,
    this.text = '',
  });
}

class Author {
  final String id;

  Author({required this.id});
}

class Tag {
  final String id;

  Tag({required this.id});
}
