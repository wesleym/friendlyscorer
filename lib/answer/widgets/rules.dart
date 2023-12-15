import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/answer/repositories/answer_rule_asses.dart';
import 'package:friendlyscorer/platform/typography.dart';
import 'package:friendlyscorer/rule/repository.dart';

class AnswerTileRules extends StatelessWidget {
  final String answerId;
  final RuleRepository _ruleRepository;
  final AnswerRuleAssociationRepository _answerRuleAssociationRepository;

  const AnswerTileRules({
    super.key,
    required this.answerId,
    required RuleRepository ruleRepository,
    required AnswerRuleAssociationRepository answerRuleAssociationRepository,
  })  : _ruleRepository = ruleRepository,
        _answerRuleAssociationRepository = answerRuleAssociationRepository;

  @override
  Widget build(BuildContext context) {
    final rulesAffectingAnswer =
        _answerRuleAssociationRepository.getRulesAffectingAnswer(answerId);
    final streamOfRulesAffectingAnswer = _answerRuleAssociationRepository
        .getStreamOfRulesAffectingAnswer(answerId);

    return StreamBuilder(
      initialData: rulesAffectingAnswer,
      stream: streamOfRulesAffectingAnswer,
      builder: (context, snapshot) {
        final rules = snapshot.data!
            .map((id) => _ruleRepository.getRuleById(id))
            .toList()
          ..sort((a, b) => a.id.compareTo(b.id));

        final bulletPoints = rules.map((r) {
          return Text(
            '• ${r.text}',
            style: bodyStyle(context),
          );
        }).toList(growable: false);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bulletPoints,
        );
      },
    );
  }
}
