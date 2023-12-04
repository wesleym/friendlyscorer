import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/data/models.dart';
import 'package:friendlyscorer/src/data/repository.dart';
import 'package:friendlyscorer/src/platform/palette.dart';
import 'package:friendlyscorer/src/platform/typography.dart';
import 'package:friendlyscorer/src/tiles.dart';

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
  final _playerAnswerAssociationRepository =
      PlayerAnswerAssociationRepository();
  final _ruleRepository = RuleRepository();
  final _answerRuleAssociationRepository = AnswerRuleAssociationRepository();

  @override
  Widget build(BuildContext context) {
    List<BoxShadow>? shadows;
    if (widget.floating) {
      shadows = const [
        BoxShadow(
          blurRadius: 4,
          offset: Offset(0, 2),
          color: CupertinoColors.systemGrey,
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
        color: platformAnswerColor(context),
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
          StreamBuilder(
            initialData: _playerAnswerAssociationRepository
                .getPlayersWhoHaveChosenAnswer(widget._answer.id),
            stream: _playerAnswerAssociationRepository
                .getPlayersWhoHaveChosenAnswerStream(widget._answer.id),
            builder: (context, snapshot) {
              final players = snapshot.data!.map((id) {
                return _playerRepository.getPlayerById(id)!;
              }).toList()
                ..sort((a, b) => a.id.compareTo(b.id));
              return Wrap(
                spacing: 4,
                children: players
                    .map((p) => PlayerCircle(player: p))
                    .toList(growable: false),
              );
            },
          ),
          const SizedBox(height: 8),
          StreamBuilder(
            initialData: _answerRuleAssociationRepository
                .getRulesAffectingAnswer(widget._answer.id),
            stream: _answerRuleAssociationRepository
                .getStreamOfRulesAffectingAnswer(widget._answer.id),
            builder: (context, snapshot) {
              final rules = snapshot.data!
                  .map((id) => _ruleRepository.getRuleById(id))
                  .toList()
                ..sort((a, b) => a.id.compareTo(b.id));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rules
                    .map((r) => Text(
                          '• ${r.text}',
                          style: bodyStyle(context),
                        ))
                    .toList(growable: false),
              );
            },
          ),
        ],
      ),
    );
  }
}
