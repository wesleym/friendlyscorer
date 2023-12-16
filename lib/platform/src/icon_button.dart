import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friendlyscorer/platform/src/button.dart';
import 'package:macos_ui/macos_ui.dart';

/// A button labeled with an icon in an appropriate style for the current
/// platform.
///
/// This button may be bordered or not, and its style may or may not match
/// text-labeled buttons like [PlatformButton].
class PlatformIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;

  const PlatformIconButton(
    this.icon, {
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoButton(
        onPressed: onPressed,
        child: Icon(icon),
      );
    } else if (!kIsWeb && Platform.isMacOS) {
      return MacosIconButton(
        icon: MacosIcon(icon),
        onPressed: onPressed,
      );
    } else {
      return IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
      );
    }
  }
}
