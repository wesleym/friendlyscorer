class PlayerIdVendor {
  static PlayerIdVendor? _instance;

  var currentId = 0;

  PlayerIdVendor._();

  factory PlayerIdVendor() => _instance ??= PlayerIdVendor._();

  int next() => currentId++;
}
