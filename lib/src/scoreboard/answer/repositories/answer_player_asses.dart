import 'dart:async';

import 'package:friendlyscorer/defaults.dart';
import 'package:friendlyscorer/src/scoreboard/answer/models.dart';

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
