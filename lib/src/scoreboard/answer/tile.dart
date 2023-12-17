import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/models.dart';
import 'package:friendlyscorer/platform.dart';
import 'package:friendlyscorer/repositories.dart';
import 'package:friendlyscorer/src/scoreboard/answer/players.dart';
import 'package:friendlyscorer/src/scoreboard/answer/rules.dart';

class _AnswerTileKey extends ValueKey<String> {
  const _AnswerTileKey(super.value);
}

class AnswerTile extends StatelessWidget {
  final Answer _answer;
  final void Function(String answerId)? _onDelete;

  static Key keyFor(String answerId) => _AnswerTileKey(answerId);

  const AnswerTile({
    super.key,
    required Answer answer,
    void Function(String answerId)? onDelete,
  })  : _answer = answer,
        _onDelete = onDelete;

  @override
  Widget build(BuildContext context) {
    final child = InnerAnswerTile(
      answer: _answer,
      onDelete: _onDelete,
    );

    return Draggable(
      data: _answer,
      feedback: InnerAnswerTile(
        floating: true,
        answer: _answer,
      ),
      child: child,
    );
  }
}

class InnerAnswerTile extends StatefulWidget {
  final bool floating;
  final Answer _answer;

  const InnerAnswerTile(
      {super.key,
      required Answer answer,
      this.floating = false,
      void Function(String answerId)? onDelete})
      : _answer = answer;

  @override
  State<InnerAnswerTile> createState() => _InnerAnswerTileState();
}

class _InnerAnswerTileState extends State<InnerAnswerTile> {
  final _playerRepository = PlayerRepository();
  final _answerPlayerAssociationRepository =
      AnswerPlayerAssociationRepository();
  final _ruleRepository = RuleRepository();
  final _answerRuleAssociationRepository = AnswerRuleAssociationRepository();

  @override
  Widget build(BuildContext context) {
    List<BoxShadow>? shadows;
    if (widget.floating) {
      shadows = [
        const BoxShadow(
          blurRadius: 4,
          offset: Offset(0, 2),
          color: PlatformColors.shadowColor,
        ),
      ];
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(2),
      constraints: const BoxConstraints(minHeight: 140),
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: PlatformColors.platformAnswerColor(context),
        shadows: shadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget._answer.text,
                style: answerTileHeading(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AnswerTilePlayers(
            answerId: widget._answer.id,
            playerRepository: _playerRepository,
            answerPlayerAssociationRepository:
                _answerPlayerAssociationRepository,
          ),
          const SizedBox(height: 8),
          AnswerTileRules(
            answerId: widget._answer.id,
            ruleRepository: _ruleRepository,
            answerRuleAssociationRepository: _answerRuleAssociationRepository,
          ),
        ],
      ),
    );
  }
}
