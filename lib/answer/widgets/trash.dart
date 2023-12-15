import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/answer/models.dart';
import 'package:friendlyscorer/platform/icon_button.dart';
import 'package:friendlyscorer/platform/icons.dart';
import 'package:friendlyscorer/platform/palette.dart';

class TrashTile extends StatefulWidget {
  final void Function(String candidate) _onDeleteAnswer;

  const TrashTile({
    super.key,
    required void Function(String candidate) onDeleteAnswer,
  }) : _onDeleteAnswer = onDeleteAnswer;

  @override
  State<TrashTile> createState() => _TrashTileState();
}

class _TrashTileState extends State<TrashTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this)
      ..repeat(period: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BoxShadow>? shadows;

    return DragTarget<Answer>(
      builder: (context, candidateData, rejectedData) {
        log('builder build with $context, $candidateData');
        final Widget trashIcon;
        if (candidateData.any((d) => d != null)) {
          trashIcon = AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: 2 * math.pi * _animationController.value,
                child: PlatformIcon(PlatformIcons.trash),
              );
            },
          );
        } else {
          trashIcon = PlatformIcon(PlatformIcons.trash);
        }

        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(2),
          height: 140,
          decoration: ShapeDecoration(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            color: platformDanger(context),
            shadows: shadows,
          ),
          alignment: Alignment.center,
          child: trashIcon,
        );
      },
      onWillAccept: (a) {
        log('builder build with $a');
        return a != null;
      },
      onAccept: (a) => widget._onDeleteAnswer(a.id),
    );
  }
}
