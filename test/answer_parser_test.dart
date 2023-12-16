import 'package:flutter_test/flutter_test.dart';
import 'package:friendlyscorer/answer_parser.dart';

void main() {
  test('answer parser parses empty string as no results', () {
    const input = '';
    const expected = <List<String>>[];
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser parses whitespace as no results', () {
    const input = ' ';
    const expected = <List<String>>[];
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser splits string with no other separators on spaces', () {
    const input = 'Britney Spears';
    const expected = [
      ['Britney', 'Spears'],
      ['Britney Spears'],
    ];
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser does not splits string with other separators on spaces',
      () {
    const input = 'Britney Spears,';
    const expected = [
      ['Britney Spears'],
      ['Britney Spears,'],
    ];
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser parses answers on multiple lines correctly', () {
    const input = '''
Britney Spears
Charles Barkley
Chevy Chase
Eddie Murphy''';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
    ];
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser parses answers on multiple lines with blank lines', () {
    const input = '''
Britney Spears

Charles Barkley

Chevy Chase

Eddie Murphy''';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
    ];
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser parses answers on multiple lines by trimming lines', () {
    const input = '''
Britney Spears

  Charles Barkley

  Chevy Chase

Eddie Murphy  ''';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
    ];
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser parses answers on multiple lines with bullets', () {
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
    expect(parseAnswers(input), equals(expected));
  });

  test(
      'answer parser parses answers on multiple lines with bullets and whitespace',
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
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser parses answers on multiple lines with numbered lines',
      () {
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
    expect(parseAnswers(input), equals(expected));
  });

  test(
      'answer parser parses answers on multiple lines with numbered lines and whitespace',
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
    expect(parseAnswers(input), equals(expected));
  });

  test(
      'answer parser parses answers on multiple lines with both numbered lines and bullets',
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
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser parses comma-separated answers', () {
    const input = 'Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      ['Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy'],
    ];
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser parses semicolon-separated answers', () {
    const input = 'Britney Spears; Charles Barkley; Chevy Chase; Eddie Murphy';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      ['Britney Spears; Charles Barkley; Chevy Chase; Eddie Murphy'],
    ];
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser parses period-separated answers', () {
    const input = 'Britney Spears. Charles Barkley. Chevy Chase. Eddie Murphy.';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      ['Britney Spears. Charles Barkley. Chevy Chase. Eddie Murphy.'],
    ];
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser parses multiple separators', () {
    const input = 'Britney Spears, Charles Barkley; Chevy Chase. Eddie Murphy.';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase. Eddie Murphy.'],
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      ['Britney Spears, Charles Barkley; Chevy Chase. Eddie Murphy.'],
    ];
    expect(parseAnswers(input), equals(expected));
  });

  test('answer parser parses single line with trailing newline', () {
    const input =
        'Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy.  \n';
    const expected = [
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy.'],
      ['Britney Spears', 'Charles Barkley', 'Chevy Chase', 'Eddie Murphy'],
      ['Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy.'],
    ];
    expect(parseAnswers(input), equals(expected));
  });
}
