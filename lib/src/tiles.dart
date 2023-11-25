import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:friendlyscorer/src/platform/typography.dart';

import 'data/models.dart';
import 'data/repository.dart';

class _AnswerTileKey extends ValueKey {
  const _AnswerTileKey(super.value);
}

class AnswerTile extends StatelessWidget {
  final Answer _answer;

  static Key keyFor(String answerId) => _AnswerTileKey(answerId);

  const AnswerTile({super.key, required Answer answer}) : _answer = answer;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: _answer,
      feedback: InnerAnswerTile(
        floating: true,
        answer: _answer,
      ),
      child: InnerAnswerTile(answer: _answer),
    );
  }
}

class InnerAnswerTile extends StatefulWidget {
  final bool floating;
  final Answer _answer;

  const InnerAnswerTile({
    super.key,
    required Answer answer,
    this.floating = false,
  }) : _answer = answer;

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

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(2),
      constraints: const BoxConstraints(minHeight: 140),
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: CupertinoTheme.of(context).primaryContrastingColor,
        shadows: shadows,
      ),
      child: Column(
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
                    .map((r) => Text('• ${r.text}'))
                    .toList(growable: false),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PlayerCircle extends StatelessWidget {
  final Player _player;

  const PlayerCircle({
    super.key,
    required Player player,
  }) : _player = player;

  @override
  Widget build(BuildContext context) {
    final displayName = _player.name;
    final hslColor = HSLColor.fromColor(_player.color);
    final color = hslColor.withLightness(hslColor.lightness + 0.2).toColor();

    return Container(
      decoration: ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(color: _player.color),
        ),
        color: color,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        displayName,
        style: bodyStyle(context),
      ),
    );
  }
}

class PlayerTile extends StatefulWidget {
  final Player _player;

  const PlayerTile({super.key, required Player player}) : _player = player;

  @override
  State<PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  late final PlayerRepository _playerRepository;
  late final PlayerAnswerAssociationRepository
      _playerAnswerAssociationRepository;

  @override
  void initState() {
    super.initState();

    _playerRepository = PlayerRepository.instance;
    _playerAnswerAssociationRepository =
        PlayerAnswerAssociationRepository.getInstance(_playerRepository);
  }

  @override
  Widget build(BuildContext context) {
    final tileTextStyle =
        answerTileHeading(context)?.copyWith(color: CupertinoColors.white);

    return DragTarget<Answer>(
      onWillAccept: (data) {
        _playerAnswerAssociationRepository.toggleAssociation(
            playerId: widget._player.id, answerId: data!.id);
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
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                HSLColor.fromColor(widget._player.color)
                    .withLightness(
                        HSLColor.fromColor(widget._player.color).lightness +
                            0.1)
                    .toColor(),
                widget._player.color
              ],
            ),
          ),
          child: Text(
            widget._player.name,
            style: tileTextStyle,
          ),
        );
      },
    );
  }
}

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

class AnswerCircle extends StatelessWidget {
  final String answer;

  const AnswerCircle({
    super.key,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Text('<MaterialAnswerCircle>');
    }

    if (Platform.isIOS) {
      return CupertinoAnswerCircle(answer: answer);
    }

    if (Platform.isMacOS) {
      return MacAnswerCircle(answer: answer);
    }

    return const Text('<MaterialAnswerCircle>');
  }
}

class CupertinoAnswerCircle extends StatelessWidget {
  final String answer;

  const CupertinoAnswerCircle({
    super.key,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = CupertinoTheme.of(context).textTheme;
    final textStyle = textTheme.textStyle;

    return Container(
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CupertinoColors.systemGreen,
            CupertinoColors.activeOrange,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        answer,
        style: textStyle,
      ),
    );
  }
}

class MacAnswerCircle extends StatelessWidget {
  final String answer;

  const MacAnswerCircle({
    super.key,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CupertinoColors.systemGreen,
            CupertinoColors.activeOrange,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.all(1),
      child: Text(answer),
    );
  }
}
