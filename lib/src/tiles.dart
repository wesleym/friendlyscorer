import 'package:flutter/cupertino.dart';

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
      feedback: InnerAnswerTile(child: child),
      child: InnerAnswerTile(child: child),
    );
  }
}

class InnerAnswerTile extends StatelessWidget {
  const InnerAnswerTile({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(2),
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: CupertinoColors.white,
      ),
      child: child,
    );
  }
}

class PlayerTile extends StatelessWidget {
  final Widget? child;

  const PlayerTile({super.key, this.child});

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
          colors: [CupertinoColors.systemYellow, CupertinoColors.systemOrange],
        ),
      ),
      child: child,
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
