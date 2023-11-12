import 'dart:async';

import '../player/palette.dart';
import 'models.dart';

final _playerColorVendor = PlayerColorVendor();

class AnswerRepository {
  static AnswerRepository? _instance;
  static get instance => _instance ??= AnswerRepository();

  final _streamController = StreamController<List<Answer>>.broadcast();

  final _answers = [
    'Britney Spears',
    'Charles Barkley',
    'Chevy Chase',
    'Eddie Murphy',
    'Elon Musk',
    'Hugh Jackman',
    'Justin Timberlake',
    'Lin-Manuel Miranda',
    'Magnus Carlsen',
    'Paul Giamatti',
    'Paul Simon',
    'Robert Downey Jr.',
    'Ruth Gordon',
    'Steve Martin',
    'Taylor Lautner',
    'Taylor Swift',
    'Tina Fey',
    'Tom Hanks',
  ].map((s) => Answer(id: s, text: s)).toList();

  List<Answer> get answers => _answers;

  Stream<List<Answer>> get answerStream => _streamController.stream;
}

class PlayerRepository {
  static PlayerRepository? _instance;
  static get instance => _instance ??= PlayerRepository();

  final _streamController = StreamController<List<Player>>.broadcast();

  final _players = [
    'Brian',
    'Chip',
    'Kathy',
    'Lex',
    'Shelley',
    'CarlGPT',
  ]
      .map((n) => Player(id: n, name: n, color: _playerColorVendor.next()))
      .toList();
  List<Player> get players => _players;
  Stream<List<Player>> get playerStream => _streamController.stream;
}

class RuleRepository {
  final _rules = [];
}
