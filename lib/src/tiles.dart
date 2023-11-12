import 'package:flutter/cupertino.dart';

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

  @override
  void initState() {
    super.initState();

    _playerRepository = PlayerRepository.instance;
    _playerAnswerAssociationRepository =
        PlayerAnswerAssociationRepository.getInstance(_playerRepository);
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
      constraints: const BoxConstraints(minHeight: 100),
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: CupertinoColors.white,
        shadows: shadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget._answer.text),
          StreamBuilder(
            initialData: _playerAnswerAssociationRepository
                .getPlayersWhoHaveChosenAnswer(widget._answer.id),
            stream: _playerAnswerAssociationRepository
                .getPlayersWhoHaveChosenAnswerStream(widget._answer.id),
            builder: (context, snapshot) {
              return Wrap(
                spacing: 2,
                children: snapshot.data!
                    .map((p) => PlayerCircle(player: p))
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
    final textTheme = CupertinoTheme.of(context).textTheme;
    final textStyle = textTheme.textStyle;

    final String displayName;
    if (_player.name.length > 2) {
      displayName = _player.name.substring(0, 2);
    } else {
      displayName = _player.name;
    }

    return Container(
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        color: _player.color,
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        displayName,
        style: textStyle,
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
          child: Text(widget._player.name),
        );
      },
    );
  }
}

class RuleTile extends StatelessWidget {
  final Widget? child;

  const RuleTile({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(2),
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: [CupertinoColors.systemTeal, CupertinoColors.systemPurple],
        ),
      ),
      child: child,
    );
  }
}
