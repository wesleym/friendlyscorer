import 'dart:async';

import 'package:friendlyscorer/src/data/defaults.dart';
import 'package:friendlyscorer/src/rule/models.dart';

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
