import 'dart:async';

import 'package:friendlyscorer/scoreboard/src/answer/models.dart';
import 'package:friendlyscorer/scoreboard/src/answer/repositories/answer_player_asses.dart';
import 'package:friendlyscorer/scoreboard/src/answer/repositories/answer_rule_asses.dart';
import 'package:friendlyscorer/defaults.dart';

class AnswerRepository {
  static AnswerRepository? _instance;

  AnswerRepository._();
  factory AnswerRepository() => _instance ??= AnswerRepository._();

  final _streamController = StreamController<List<Answer>>.broadcast();

  final _answers = defaultAnswers.toList();

  List<Answer> get answers => _answers;
  Stream<List<Answer>> get answerStream => _streamController.stream;

  void add(Answer answer) {
    if (_answers.any((a) => a.id == answer.id)) return;
    _answers.add(answer);
    _streamController.add(_answers);
  }

  void remove(String answerId) {
    AnswerRuleAssociationRepository().removeAllByAnswer(answerId);
    AnswerPlayerAssociationRepository().removeAllByAnswer(answerId);
    _answers.removeWhere((a) => a.id == answerId);
    _streamController.add(_answers);
  }

  void clear() {
    _answers.clear();
    _streamController.add(_answers);
  }
}