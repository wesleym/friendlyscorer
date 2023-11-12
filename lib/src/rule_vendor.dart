class RuleIdVendor {
  var currentLetter = 'A';

  String next() {
    final result = currentLetter;
    currentLetter = String.fromCharCode(currentLetter.codeUnitAt(0) + 1);
    return result;
  }
}
