import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/platform/typography.dart';

import 'data/models.dart';

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

class MaterialAnswerCircle extends StatelessWidget {
  final String answer;

  const MaterialAnswerCircle({
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
      child: Text(
        answer,
        style: bodyStyle(context),
      ),
    );
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
        style: bodyStyle(context),
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
