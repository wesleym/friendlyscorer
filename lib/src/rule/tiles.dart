import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/data/models.dart';
import 'package:friendlyscorer/src/data/repository.dart';
import 'package:friendlyscorer/src/platform/text_field.dart';
import 'package:friendlyscorer/src/platform/typography.dart';

class RuleTile extends StatefulWidget {
  final Rule _rule;

  const RuleTile({super.key, required Rule rule}) : _rule = rule;

  @override
  State<RuleTile> createState() => _RuleTileState();
}

class _RuleTileState extends State<RuleTile> {
  late final RuleRepository _ruleRepository;
  late final AnswerRuleAssociationRepository _answerRuleAssociationRepository;

  @override
  void initState() {
    super.initState();

    _ruleRepository = RuleRepository.instance;
    _answerRuleAssociationRepository =
        AnswerRuleAssociationRepository.getInstance(_ruleRepository);
  }

  @override
  Widget build(BuildContext context) {
    final tileTextStyle =
        answerTileHeading(context)?.copyWith(color: CupertinoColors.white);

    return DragTarget<Answer>(
      onWillAccept: (data) {
        _answerRuleAssociationRepository.toggleAssociation(
            ruleId: widget._rule.id, answerId: data!.id);
        return false;
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(2),
          decoration: ShapeDecoration(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                CupertinoColors.systemTeal,
                CupertinoColors.systemPurple
              ],
            ),
          ),
          child: Text(
            widget._rule.text,
            style: tileTextStyle,
          ),
        );
      },
    );
  }
}

class NewRuleTile extends StatefulWidget {
  final void Function(String name)? _onCreateRule;

  const NewRuleTile({
    super.key,
    void Function(String name)? onCreateRule,
  }) : _onCreateRule = onCreateRule;

  @override
  State<NewRuleTile> createState() => _NewRuleTileState();
}

class _NewRuleTileState extends State<NewRuleTile> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tileTextStyle =
        answerTileHeading(context)?.copyWith(color: CupertinoColors.white);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(2),
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [CupertinoColors.systemTeal, CupertinoColors.systemPurple],
        ),
      ),
      child: PlatformInvisibleTextField(
        controller: _controller,
        style: tileTextStyle,
        placeholder: 'Special rule',
        onSubmitted: (String value) {
          widget._onCreateRule?.call(value);
          _controller.clear();
        },
      ),
    );
  }
}
