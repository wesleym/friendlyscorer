import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/answer/models.dart';
import 'package:friendlyscorer/answer/repositories/answer_player_asses.dart';
import 'package:friendlyscorer/platform/palette.dart';
import 'package:friendlyscorer/platform/text_field.dart';
import 'package:friendlyscorer/platform/typography.dart';
import 'package:friendlyscorer/player/models.dart';
import 'package:friendlyscorer/player/palette.dart';

class PlayerTile extends StatefulWidget {
  final Player _player;

  const PlayerTile({super.key, required Player player}) : _player = player;

  @override
  State<PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  late final AnswerPlayerAssociationRepository
      _answerPlayerAssociationRepository;

  @override
  void initState() {
    super.initState();

    _answerPlayerAssociationRepository = AnswerPlayerAssociationRepository();
  }

  @override
  Widget build(BuildContext context) {
    final pColors = playerColors(context);
    final color = pColors[int.parse(widget._player.id) % pColors.length];

    return DragTarget<Answer>(
      onWillAccept: (data) {
        _answerPlayerAssociationRepository.toggleAssociation(
            playerId: widget._player.id, answerId: data!.id);
        return false;
      },
      builder: (context, candidateData, rejectedData) {
        var lightColor = HSLColor.fromColor(color)
            .withLightness(HSLColor.fromColor(color).lightness + 0.1)
            .toColor();
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
                lightColor,
                color,
              ],
            ),
          ),
          child: Text(
            widget._player.name,
            style: playerTileHeading(context),
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
    final tileColor = newPlayerTileColor();

    var lightTileColor = HSLColor.fromColor(tileColor)
        .withLightness(HSLColor.fromColor(tileColor).lightness + 0.1)
        .toColor();

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
          colors: [lightTileColor, tileColor],
        ),
      ),
      child: PlatformInvisibleTextField(
        style: answerTileHeading(context),
        placeholder: 'Player',
        controller: _controller,
        onSubmitted: (value) {
          widget._onCreatePlayer?.call(value);
          _controller.clear();
        },
      ),
    );
  }
}
