import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

/// A collection of meaningful colors for Friendly Scorer mapped to
/// platform-specific or platform-appropriate colors.
class PlatformColors {
  PlatformColors._();

  /// The color of a tile representing a user-submitted answer.
  static Color platformAnswerColor(BuildContext context) {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoColors.systemFill;
    } else if (!kIsWeb && Platform.isMacOS) {
      return MacosColors.controlBackgroundColor.resolveFrom(context);
    } else {
      return Theme.of(context).colorScheme.primaryContainer;
    }
  }

  /// The color of the empty area on which tiles are placed.
  static Color platformCanvasColor(BuildContext context) {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoColors.systemBackground;
    } else if (!kIsWeb && Platform.isMacOS) {
      return MacosTheme.of(context).canvasColor;
    } else {
      return Theme.of(context).colorScheme.background;
    }
  }

  /// The color of controls that perform destructive actions.
  ///
  /// This color is also used for messages warning about destructive actions.
  static Color get platformDanger {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoColors.destructiveRed;
    } else if (!kIsWeb && Platform.isMacOS) {
      return MacosColors.appleRed;
    } else {
      return Colors.red;
    }
  }

  /// When [platformDanger] is used as a background, this color can legibly be
  /// used for foreground elements.
  static Color ontoPlatformDanger(BuildContext context) {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoColors.label;
    } else if (!kIsWeb && Platform.isMacOS) {
      return MacosColors.labelColor;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }

  /// A color that draws legible foreground elements onto any player tile
  /// background.
  ///
  /// Player tiles vary in color, but this color should be legible on any of
  /// them.
  static Color get ontoPlatformPlayer {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoColors.white;
    } else if (!kIsWeb && Platform.isMacOS) {
      return MacosColors.white;
    } else {
      return Colors.white;
    }
  }

  /// The colors that make up the background gradient of a special rule tile.
  static const ruleTileColors = [
    CupertinoColors.systemGreen,
    CupertinoColors.activeOrange,
  ];

  /// A color that draws legible foreground elements onto the special rule
  /// tiles.
  static Color get ontoPlatformRule {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoColors.white;
    } else if (!kIsWeb && Platform.isMacOS) {
      return MacosColors.white;
    } else {
      return Colors.white;
    }
  }

  /// A color to draw the headings of the sections of the scoreboard.
  static const sectionHeadingColor = CupertinoColors.inactiveGray;

  /// A color to draw the shadow under a dragged tile.
  static const shadowColor = CupertinoColors.systemGrey;

  /// A color to use as the background of the tile for adding new players.
  ///
  /// This color is chosen to avoid possible collisions with actual player
  /// colors.
  static const newPlayerTileColor = CupertinoColors.inactiveGray;

  /// The colors that make up the background gradient one candidate answer in a
  /// list of parsed candidate answers.
  static const answerCandidateChipColors = [
    CupertinoColors.systemGreen,
    CupertinoColors.activeOrange,
  ];
}
