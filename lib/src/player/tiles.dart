import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/data/models.dart';
import 'package:friendlyscorer/src/data/repository.dart';
import 'package:friendlyscorer/src/platform/text_field.dart';
import 'package:friendlyscorer/src/platform/typography.dart';

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

class NewPlayerTile extends StatefulWidget {
  final void Function(String name)? _onCreatePlayer;

  const NewPlayerTile({
    super.key,
    void Function(String name)? onCreatePlayer,
  }) : _onCreatePlayer = onCreatePlayer;

  @override
  State<NewPlayerTile> createState() => _NewPlayerTileState();
}

class _NewPlayerTileState extends State<NewPlayerTile> {
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            HSLColor.fromColor(CupertinoColors.inactiveGray)
                .withLightness(
                    HSLColor.fromColor(CupertinoColors.inactiveGray).lightness +
                        0.1)
                .toColor(),
            CupertinoColors.inactiveGray,
          ],
        ),
      ),
      child: PlatformInvisibleTextField(
        style: tileTextStyle,
        placeholder: 'Player',
        controller: _controller,
        onSubmitted: (value) {
          widget._onCreatePlayer?.call(value);
          _controller.clear();
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}