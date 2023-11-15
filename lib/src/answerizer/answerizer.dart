List<List<String>> answerizer(String answer) {
  answer = answer.trim();
  if (answer.contains('\n')) {
    final lines = answer.split('\n');
    return _answerizerMultiline(lines);
  } else {
    final line = answer.trim();
    return _answerizerSingleLine(line);
  }
}

List<List<String>> _answerizerSingleLine(String answer) {
  final results = <List<String>>[];

  if (answer.contains(RegExp(r'[,;]'))) {
    final tokens = answer.split(RegExp(r'[,;]'));
    final rawResults = tokens
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);
    if (rawResults.any((e) => e.startsWith(RegExp(r'\s*[\W\d]')))) {
      results.add(rawResults.map((e) {
        if (e.startsWith(RegExp(r'\s*\W'))) {
          return e.replaceFirst(RegExp(r'^\s*\W'), '').trim();
        } else if (e.startsWith(RegExp(r'\s*\d'))) {
          return e.replaceFirst(RegExp(r'^\(?\s*\d+\s*(\.|\)|\:)'), '').trim();
        } else {
          return e;
        }
      }).toList(growable: false));
    }
    results.add(rawResults);

    if (answer.contains('.')) {
      final tokens = answer.split(RegExp(r'[,;.]'));
      final rawResults = tokens
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(growable: false);
      if (rawResults.any((e) => e.startsWith(RegExp(r'\s*[\W\d]')))) {
        results.add(rawResults.map((e) {
          if (e.startsWith(RegExp(r'\s*\W'))) {
            return e.replaceFirst(RegExp(r'^\s*\W'), '').trim();
          } else if (e.startsWith(RegExp(r'\s*\d'))) {
            return e
                .replaceFirst(RegExp(r'^\(?\s*\d+\s*(\.|\)|\:)'), '')
                .trim();
          } else {
            return e;
          }
        }).toList(growable: false));
      }
      results.add(rawResults);
    }
  } else if (answer.contains('.')) {
    final tokens = answer.split('.');
    final rawResults = tokens
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);
    if (rawResults.any((e) => e.startsWith(RegExp(r'\s*[\W\d]')))) {
      results.add(rawResults.map((e) {
        if (e.startsWith(RegExp(r'\s*\W'))) {
          return e.replaceFirst(RegExp(r'^\s*\W'), '').trim();
        } else if (e.startsWith(RegExp(r'\s*\d'))) {
          return e.replaceFirst(RegExp(r'^\(?\s*\d+\s*(\.|\)|\:)'), '').trim();
        } else {
          return e;
        }
      }).toList(growable: false));
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
  if (rawResults.any((e) => e.startsWith(RegExp(r'\s*[\W\d]')))) {
    results.add(rawResults.map((e) {
      if (e.startsWith(RegExp(r'\s*\W'))) {
        return e.replaceFirst(RegExp(r'^\s*\W'), '').trim();
      } else if (e.startsWith(RegExp(r'\s*\d'))) {
        return e.replaceFirst(RegExp(r'^\(?\s*\d+\s*(\.|\)|\:)'), '').trim();
      } else {
        return e;
      }
    }).toList(growable: false));
  }
  results.add(rawResults);
  return results;
}
