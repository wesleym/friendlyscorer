import 'package:flutter/cupertino.dart';

class AnswerTile extends StatelessWidget {
  final Widget? child;

  const AnswerTile({super.key, this.child});

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
          colors: [CupertinoColors.activeGreen, CupertinoColors.systemBlue],
        ),
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
