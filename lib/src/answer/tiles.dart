import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/answerizer/answerizer.dart';
import 'package:friendlyscorer/src/answerizer/compact_display.dart';
import 'package:friendlyscorer/src/data/models.dart';
import 'package:friendlyscorer/src/data/repository.dart';
import 'package:friendlyscorer/src/editing/editing.dart';
import 'package:friendlyscorer/src/platform/icon_button.dart';
import 'package:friendlyscorer/src/platform/icons.dart';
import 'package:friendlyscorer/src/platform/palette.dart';
import 'package:friendlyscorer/src/platform/text_field.dart';
import 'package:friendlyscorer/src/platform/typography.dart';
import 'package:friendlyscorer/src/tiles.dart';

class _AnswerTileKey extends ValueKey {
  const _AnswerTileKey(super.value);
}

class AnswerTile extends StatelessWidget {
  final Answer _answer;
  final void Function(String answerId)? _onDelete;

  static Key keyFor(String answerId) => _AnswerTileKey(answerId);

  const AnswerTile(
      {super.key,
      required Answer answer,
      void Function(String answerId)? onDelete})
      : _answer = answer,
        _onDelete = onDelete;

  @override
  Widget build(BuildContext context) {
    final child = InnerAnswerTile(
      answer: _answer,
      onDelete: _onDelete,
    );

    if (EditingProvider.of(context).editing) {
      return child;
    }

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
  final void Function(String answerId)? _onDelete;

  const InnerAnswerTile(
      {super.key,
      required Answer answer,
      this.floating = false,
      void Function(String answerId)? onDelete})
      : _answer = answer,
        _onDelete = onDelete;

  @override
  State<InnerAnswerTile> createState() => _InnerAnswerTileState();
}

class _InnerAnswerTileState extends State<InnerAnswerTile> {
  late final PlayerRepository _playerRepository;
  late final PlayerAnswerAssociationRepository
      _playerAnswerAssociationRepository;
  late final RuleRepository _ruleRepository;
  late final AnswerRuleAssociationRepository _answerRuleAssociationRepository;

  @override
  void initState() {
    super.initState();

    _playerRepository = PlayerRepository.instance;
    _playerAnswerAssociationRepository =
        PlayerAnswerAssociationRepository.getInstance(_playerRepository);
    _ruleRepository = RuleRepository.instance;
    _answerRuleAssociationRepository =
        AnswerRuleAssociationRepository.getInstance(_ruleRepository);
  }

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

    Widget? deleteButton;
    final onDelete = widget._onDelete;
    if (onDelete != null) {
      deleteButton = PlatformIconButton(
        PlatformIcons.delete,
        onPressed: () => onDelete(widget._answer.id),
      );
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget._answer.text,
                style: answerTileHeading(context),
              ),
              const SizedBox(height: 8),
              StreamBuilder(
                initialData: _playerAnswerAssociationRepository
                    .getPlayersWhoHaveChosenAnswer(widget._answer.id),
                stream: _playerAnswerAssociationRepository
                    .getPlayersWhoHaveChosenAnswerStream(widget._answer.id),
                builder: (context, snapshot) {
                  final data = snapshot.data!;
                  data.sort((a, b) => a.id.compareTo(b.id));
                  return Wrap(
                    spacing: 4,
                    children: data
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
                  final data = snapshot.data!;
                  data.sort((a, b) => a.id.compareTo(b.id));
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data
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
          if (deleteButton != null) deleteButton,
        ],
      ),
    );
  }
}

class NewInnerAnswerTile extends StatefulWidget {
  final Function(List<String> candidates)? _onAddAnswers;

  const NewInnerAnswerTile({
    super.key,
    Function(List<String> candidates)? onAddAnswers,
  }) : _onAddAnswers = onAddAnswers;

  @override
  State<NewInnerAnswerTile> createState() => _NewInnerAnswerTileState();
}

class _NewInnerAnswerTileState extends State<NewInnerAnswerTile> {
  final _controller = TextEditingController();

  var _candidates = <List<String>>[];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _candidates = answerizer(_controller.value.text);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BoxShadow>? shadows;

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
        children: [
          PlatformInvisibleTextField(
            controller: _controller,
            style: answerTileHeading(context),
            placeholder: 'Answer(s)',
            onSubmitted: (_) {
              if (_candidates.isEmpty) return;
              _onSelectAnswer(_candidates.first);
            },
          ),
          const SizedBox(height: 8),
          CompactResultDisplay(
            results: _candidates,
            onSelect: _onSelectAnswer,
          ),
        ],
      ),
    );
  }

  void _onSelectAnswer(List<String> answerCandidates) {
    widget._onAddAnswers?.call(answerCandidates);
    _controller.clear();
  }
}
