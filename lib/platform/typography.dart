import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friendlyscorer/platform/palette.dart';
import 'package:macos_ui/macos_ui.dart';

TextStyle? answerTileHeading(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return CupertinoTheme.of(context).textTheme.navTitleTextStyle;
  } else if (!kIsWeb && Platform.isMacOS) {
    return MacosTheme.of(context).typography.headline;
  } else {
    return Theme.of(context).textTheme.titleLarge;
  }
}

TextStyle? playerTileHeading(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return CupertinoTheme.of(context).textTheme.navTitleTextStyle;
  } else if (!kIsWeb && Platform.isMacOS) {
    return MacosTheme.of(context).typography.headline;
  } else {
    return Theme.of(context).textTheme.titleLarge;
  }
}

TextStyle? bodyStyle(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return CupertinoTheme.of(context).textTheme.textStyle;
  } else if (!kIsWeb && Platform.isMacOS) {
    return MacosTheme.of(context).typography.body;
  } else {
    return Theme.of(context).textTheme.bodyMedium;
  }
}

TextStyle? playerCircleStyle(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return CupertinoTheme.of(context)
        .textTheme
        .textStyle
        .copyWith(color: ontoPlatformPlayer(context));
  } else if (!kIsWeb && Platform.isMacOS) {
    return MacosTheme.of(context)
        .typography
        .body
        .copyWith(color: ontoPlatformPlayer(context));
  } else {
    return Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: ontoPlatformPlayer(context));
  }
}
