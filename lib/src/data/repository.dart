import 'dart:async';

import 'models.dart';

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
  final _players = [];
}

class RuleRepository {
  final _rules = [];
}
