import 'package:flutter_test/flutter_test.dart';
import 'package:friendlyscorer/src/answerizer/answerizer.dart';

void main() {
  test('answerizer parses answers on multiple lines correctly', () {
    const input = '''
Britney Spears
Charles Barkley
Chevy Chase
Eddie Murphy''';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
    ];
    expect(answerizer(input), equals(expected));
  });

  test('answerizer parses answers on multiple lines with blank lines', () {
    const input = '''
Britney Spears

Charles Barkley

Chevy Chase

Eddie Murphy''';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
    ];
    expect(answerizer(input), equals(expected));
  });

  test('answerizer parses answers on multiple lines by trimming lines', () {
    const input = '''
Britney Spears

  Charles Barkley

  Chevy Chase

Eddie Murphy  ''';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
    ];
    expect(answerizer(input), equals(expected));
  });

  test('answerizer parses answers on multiple lines with bullets', () {
    const input = '''
* Britney Spears

- Charles Barkley

> Chevy Chase

  Eddie Murphy''';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      [
        '* Britney Spears',
        '- Charles Barkley',
        '> Chevy Chase',
        'Eddie Murphy',
      ],
    ];
    expect(answerizer(input), equals(expected));
  });

  test(
      'answerizer parses answers on multiple lines with bullets and whitespace',
      () {
    const input = '''
  * Britney Spears

  - Charles Barkley

  > Chevy Chase

  Eddie Murphy  ''';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      [
        '* Britney Spears',
        '- Charles Barkley',
        '> Chevy Chase',
        'Eddie Murphy',
      ],
    ];
    expect(answerizer(input), equals(expected));
  });

  test('answerizer parses answers on multiple lines with numbered lines', () {
    const input = '''
1. Britney Spears

2) Charles Barkley

3: Chevy Chase

  Eddie Murphy''';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      [
        '1. Britney Spears',
        '2) Charles Barkley',
        '3: Chevy Chase',
        'Eddie Murphy',
      ],
    ];
    expect(answerizer(input), equals(expected));
  });

  test(
      'answerizer parses answers on multiple lines with numbered lines and whitespace',
      () {
    const input = '''
  1. Britney Spears

  2) Charles Barkley

  3: Chevy Chase

    Eddie Murphy  ''';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      [
        '1. Britney Spears',
        '2) Charles Barkley',
        '3: Chevy Chase',
        'Eddie Murphy',
      ],
    ];
    expect(answerizer(input), equals(expected));
  });

  test(
      'answerizer parses answers on multiple lines with both numbered lines and bullets',
      () {
    const input = '''
1. Britney Spears
2) Charles Barkley
- Chevy Chase
* Eddie Murphy''';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      [
        '1. Britney Spears',
        '2) Charles Barkley',
        '- Chevy Chase',
        '* Eddie Murphy',
      ],
    ];
    expect(answerizer(input), equals(expected));
  });

  test('answerizer parses comma-separated answers', () {
    const input = 'Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      ['Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy'],
    ];
    expect(answerizer(input), equals(expected));
  });

  test('answerizer parses semicolon-separated answers', () {
    const input = 'Britney Spears; Charles Barkley; Chevy Chase; Eddie Murphy';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      ['Britney Spears; Charles Barkley; Chevy Chase; Eddie Murphy'],
    ];
    expect(answerizer(input), equals(expected));
  });

  test('answerizer parses period-separated answers', () {
    const input = 'Britney Spears. Charles Barkley. Chevy Chase. Eddie Murphy.';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      ['Britney Spears. Charles Barkley. Chevy Chase. Eddie Murphy.'],
    ];
    expect(answerizer(input), equals(expected));
  });

  test('answerizer parses multiple separators', () {
    const input = 'Britney Spears, Charles Barkley; Chevy Chase. Eddie Murphy.';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase. Eddie Murphy.'],
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      ['Britney Spears, Charles Barkley; Chevy Chase. Eddie Murphy.'],
    ];
    expect(answerizer(input), equals(expected));
  });

  test('answerizer parses single line with trailing newline', () {
    const input =
        'Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy.  \n';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy.'],
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      ['Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy.'],
    ];
    expect(answerizer(input), equals(expected));
  });
}
