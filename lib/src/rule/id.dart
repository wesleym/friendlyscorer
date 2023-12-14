class RuleIdVendor {
  static RuleIdVendor? _instance;

  var currentId = 0;

  RuleIdVendor._();

  factory RuleIdVendor() => _instance ??= RuleIdVendor._();

  int next() => currentId++;
}
