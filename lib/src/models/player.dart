/// A participant that submits answers.
class Player {
  /// A unique identifier for this rule.
  ///
  /// Consider using [PlayerIdVendor].
  final String id;
  final String name;

  Player({
    required this.id,
    required this.name,
  });
}

class PlayerIdVendor {
  static PlayerIdVendor? _instance;

  var currentId = 0;

  PlayerIdVendor._();

  factory PlayerIdVendor() => _instance ??= PlayerIdVendor._();

  int next() => currentId++;
}
