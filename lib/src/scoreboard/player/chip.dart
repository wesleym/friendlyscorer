import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/models.dart';
import 'package:friendlyscorer/platform.dart';
import 'package:friendlyscorer/src/scoreboard/player/palette.dart';

class PlayerChip extends StatelessWidget {
  final Player _player;

  const PlayerChip({
    super.key,
    required Player player,
  }) : _player = player;

  @override
  Widget build(BuildContext context) {
    final displayName = _player.name;

    final pColors = playerColors(context);
    final color = pColors[int.parse(_player.id) % pColors.length];

    return Container(
      decoration: ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(color: color),
        ),
        color: color,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        displayName,
        style: playerCircleStyle(context),
      ),
    );
  }
}
