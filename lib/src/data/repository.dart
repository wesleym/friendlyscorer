import 'dart:async';

import 'defaults.dart';
import 'models.dart';

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
    PlayerAnswerAssociationRepository().removeAllByAnswer(answerId);
    _answers.removeWhere((a) => a.id == answerId);
    _streamController.add(_answers);
  }

  void clear() {
    _answers.clear();
    _streamController.add(_answers);
  }
}

class PlayerRepository {
  static PlayerRepository? _instance;

  PlayerRepository._();
  factory PlayerRepository() => _instance ??= PlayerRepository._();

  final _streamController = StreamController<List<Player>>.broadcast();

  final _players = defaultPlayers.toList();
  List<Player> get players => _players;
  Stream<List<Player>> get playerStream => _streamController.stream;

  Player? getPlayerById(String playerId) =>
      _players.where((p) => p.id == playerId).singleOrNull;

  void clear() {
    _players.clear();
    _streamController.add(_players);
  }

  void add(Player player) {
    _players.add(player);
    _streamController.add(_players);
  }
}

class RuleRepository {
  static RuleRepository? _instance;

  RuleRepository._();
  factory RuleRepository() => _instance ??= RuleRepository._();

  final _streamController = StreamController<List<Rule>>.broadcast();

  final _rules = defaultRules.toList();
  List<Rule> get rules => _rules;
  Stream<List<Rule>> get ruleStream => _streamController.stream;

  Rule getRuleById(String ruleId) => _rules.singleWhere((r) => r.id == ruleId);

  void clear() {
    _rules.clear();
    _streamController.add(_rules);
  }

  void add(Rule rule) {
    _rules.add(rule);
    _streamController.add(_rules);
  }
}

class PlayerAnswerAssociation {
  final String playerId;
  final String answerId;

  PlayerAnswerAssociation({required this.playerId, required this.answerId});
}

class PlayerAnswerAssociationRepository {
  static PlayerAnswerAssociationRepository? _instance;

  final _associations = defaultPlayerAnswerAssociations.toList();
  final _streamController =
      StreamController<List<PlayerAnswerAssociation>>.broadcast();

  factory PlayerAnswerAssociationRepository() =>
      _instance ??= PlayerAnswerAssociationRepository._();
  PlayerAnswerAssociationRepository._();

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
    _associations.add(PlayerAnswerAssociation(
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

  removeAllByAnswer(String answerId) {
    _associations.removeWhere((a) => a.answerId == answerId);
    _streamController.add(_associations);
  }
}

class AnswerRuleAssociation {
  final String ruleId;
  final String answerId;

  AnswerRuleAssociation({required this.ruleId, required this.answerId});
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
