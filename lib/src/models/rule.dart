/// A special rule that may apply to answers in a round.
class Rule {
  /// A unique identifier for this rule.
  ///
  /// Consider using [RuleIdVendor].
  final String id;
  final String text;

  Rule({
    required this.id,
    required this.text,
  });
}

class RuleIdVendor {
  static RuleIdVendor? _instance;

  var currentId = 0;

  RuleIdVendor._();

  factory RuleIdVendor() => _instance ??= RuleIdVendor._();

  int next() => currentId++;
}
