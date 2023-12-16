/// Parses [input] into different possible sets of answers.
///
/// This method will try to guess different ways that the input string
/// represents different answers. Each element of the returned list represents
/// one interpretation of the input. See the unit tests for examples.
List<List<String>> parseAnswers(String input) {
  input = input.trim();

  if (input.isEmpty) return [];

  if (input.contains('\n')) {
    final lines = input.split('\n');
    return _parseAnswersMultiline(lines);
  } else {
    final line = input.trim();
    return _parseAnswersSingleLine(line);
  }
}

List<List<String>> _parseAnswersSingleLine(String answer) {
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
  } else if (answer.contains(RegExp(r'\s'))) {
    final tokens = answer.split(RegExp(r'\s+'));
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

List<List<String>> _parseAnswersMultiline(List<String> rawLines) {
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
