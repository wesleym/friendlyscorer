List<List<String>> answerizer(String answer) {
  answer = answer.trim();
  if (answer.contains('\n')) {
    final lines = answer.split('\n');
    return _answerizerMultiline(lines);
  }

  final results = <List<String>>[];

  if (answer.contains(',')) {
    final tokens = answer.split(',');
    final rawResults = tokens
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);
    if (rawResults.any((e) => e.startsWith(RegExp(r'\s*\W')))) {
      results.add(rawResults
          .map((e) => e.replaceFirst(RegExp(r'^\s*\W'), '').trim())
          .toList(growable: false));
    }
    if (rawResults.any((e) => e.startsWith(RegExp(r'\s*\d')))) {
      results.add(rawResults
          .map((e) =>
              e.replaceFirst(RegExp(r'^\(?\s*\d+\s*(\.|\)|\:)'), '').trim())
          .toList(growable: false));
    }
    results.add(rawResults);
  }

  if (answer.contains(';')) {
    final tokens = answer.split(';');
    final rawResults = tokens
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);
    if (rawResults.any((e) => e.startsWith(RegExp(r'\s\W')))) {
      results.add(rawResults
          .map((e) => e.replaceFirst(RegExp(r'^\s\W'), '').trim())
          .toList(growable: false));
    }
    if (rawResults.any((e) => e.startsWith(RegExp(r'\s*\d')))) {
      results.add(rawResults
          .map((e) =>
              e.replaceFirst(RegExp(r'^\(?\s*\d+\s*(\.|\)|\:)'), '').trim())
          .toList(growable: false));
    }
    results.add(rawResults);
  }

  if (answer.contains('.')) {
    final tokens = answer.split('.');
    final rawResults = tokens
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);
    if (rawResults.any((e) => e.startsWith(RegExp(r'\s*\W')))) {
      results.add(rawResults
          .map((e) => e.replaceFirst(RegExp(r'^\s*\W'), '').trim())
          .toList(growable: false));
    }
    if (rawResults.any((e) => e.startsWith(RegExp(r'\s*\d')))) {
      results.add(rawResults
          .map((e) =>
              e.replaceFirst(RegExp(r'^\(?\s*\d+\s*(\.|\)|\:):'), '').trim())
          .toList(growable: false));
    }
    results.add(rawResults);
  }

  results.add([answer.trim()]);

  return results;
}

List<List<String>> _answerizerMultiline(List<String> rawLines) {
  final results = <List<String>>[];
  final rawResults = rawLines
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList(growable: false);
  if (rawResults.any((e) => e.startsWith(RegExp(r'\s*\W')))) {
    results.add(rawResults
        .map((e) => e.replaceFirst(RegExp(r'^\s*\W'), '').trim())
        .toList(growable: false));
  }
  if (rawResults.any((e) => e.startsWith(RegExp(r'\s*\d')))) {
    results.add(rawResults
        .map((e) => e.replaceFirst(RegExp(r'^\s*\d+\s*(\.|\)|\:)'), '').trim())
        .toList(growable: false));
  }
  results.add(rawResults);
  return results;
}
