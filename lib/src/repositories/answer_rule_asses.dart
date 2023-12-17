import 'dart:async';

import 'package:friendlyscorer/defaults.dart';
import 'package:friendlyscorer/models.dart';

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
