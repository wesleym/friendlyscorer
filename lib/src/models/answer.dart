/// A single answer submitted by a player during a round.
class Answer {
  /// A unique identifier for this answer.
  final String id;
  String text;

  Answer({
    required this.id,
    required this.text,
  });
}
