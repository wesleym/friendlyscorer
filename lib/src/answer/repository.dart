import 'dart:async';

import 'package:friendlyscorer/src/answer/models.dart';
import 'package:friendlyscorer/src/defaults.dart';

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

class AnswerPlayerAssociationRepository {
  static AnswerPlayerAssociationRepository? _instance;

  final _associations = defaultAnswerPlayerAssociations.toList();
  final _streamController =
      StreamController<List<AnswerPlayerAssociation>>.broadcast();

  factory AnswerPlayerAssociationRepository() =>
      _instance ??= AnswerPlayerAssociationRepository._();
  AnswerPlayerAssociationRepository._();

  List<String> getPlayersWhoHaveChosenAnswer(String answerId) {
    return _associations
        .where((a) => a.answerId == answerId)
        .map((a) => a.playerId)
        .nonNulls
        .toList(growable: false);
  }

  Stream<List<String>> getPlayersWhoHaveChosenAnswerStream(String answerId) {
    return _streamController.stream.map((asses) {
      return asses
          .where((a) => a.answerId == answerId)
          .map((a) => a.playerId)
          .nonNulls
          .toList(growable: false);
    });
  }

  void addAssociation({
    required String playerId,
    required String answerId,
  }) {
    _associations.add(AnswerPlayerAssociation(
      playerId: playerId,
      answerId: answerId,
    ));
    _streamController.add(_associations);
  }

  void removeAssociation({
    required String playerId,
    required String answerId,
  }) {
    _associations
        .removeWhere((a) => a.playerId == playerId && a.answerId == answerId);
    _streamController.add(_associations);
  }

  void toggleAssociation({
    required String playerId,
    required String answerId,
  }) {
    if (_associations
        .any((a) => a.playerId == playerId && a.answerId == answerId)) {
      removeAssociation(playerId: playerId, answerId: answerId);
    } else {
      addAssociation(playerId: playerId, answerId: answerId);
    }
  }

  void removeAllByAnswer(String answerId) {
    _associations.removeWhere((a) => a.answerId == answerId);
    _streamController.add(_associations);
  }
}

class AnswerRuleAssociationRepository {
  static AnswerRuleAssociationRepository? _instance;

  final _associations = defaultAnswerRuleAssociations.toList();
  final _streamController =
      StreamController<List<AnswerRuleAssociation>>.broadcast();

  factory AnswerRuleAssociationRepository() =>
      _instance ??= AnswerRuleAssociationRepository._();
  AnswerRuleAssociationRepository._();

  List<String> getRulesAffectingAnswer(String answerId) {
    return _associations
        .where((a) => a.answerId == answerId)
        .map((a) => a.ruleId)
        .toList(growable: false);
  }

  Stream<List<String>> getStreamOfRulesAffectingAnswer(String answerId) {
    return _streamController.stream.map((asses) {
      return asses
          .where((a) => a.answerId == answerId)
          .map((a) => a.ruleId)
          .toList(growable: false);
    });
  }

  void addAssociation({
    required String ruleId,
    required String answerId,
  }) {
    _associations.add(AnswerRuleAssociation(
      ruleId: ruleId,
      answerId: answerId,
    ));
    _streamController.add(_associations);
  }

  void removeAssociation({
    required String ruleId,
    required String answerId,
  }) {
    _associations
        .removeWhere((a) => a.ruleId == ruleId && a.answerId == answerId);
    _streamController.add(_associations);
  }

  void toggleAssociation({
    required String ruleId,
    required String answerId,
  }) {
    if (_associations
        .any((a) => a.ruleId == ruleId && a.answerId == answerId)) {
      removeAssociation(ruleId: ruleId, answerId: answerId);
    } else {
      addAssociation(ruleId: ruleId, answerId: answerId);
    }
  }

  void removeAllByAnswer(String answerId) {
    _associations.removeWhere((a) => a.answerId == answerId);
    _streamController.add(_associations);
  }
}
