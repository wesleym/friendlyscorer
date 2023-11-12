import 'package:flutter/cupertino.dart';

import 'data/models.dart';

class _AnswerTileKey extends ValueKey {
  const _AnswerTileKey(super.value);
}

class AnswerTile extends StatelessWidget {
  final Widget? child;

  static Key keyFor(String answerId) => _AnswerTileKey(answerId);

  const AnswerTile({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: InnerAnswerTile(
        floating: true,
        child: child,
      ),
      child: InnerAnswerTile(child: child),
    );
  }
}

class InnerAnswerTile extends StatelessWidget {
  final bool floating;

  const InnerAnswerTile({
    super.key,
    required this.child,
    this.floating = false,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    List<BoxShadow>? shadows;
    if (floating) {
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
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: CupertinoColors.white,
        shadows: shadows,
      ),
      child: child,
    );
  }
}

class PlayerTile extends StatelessWidget {
  final Player _player;

  const PlayerTile({super.key, required Player player}) : _player = player;

  @override
  Widget build(BuildContext context) {
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
            HSLColor.fromColor(_player.color)
                .withLightness(
                    HSLColor.fromColor(_player.color).lightness + 0.1)
                .toColor(),
            _player.color
          ],
        ),
      ),
      child: Text(_player.name),
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
