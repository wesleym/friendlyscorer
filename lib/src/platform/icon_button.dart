import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

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

class PlatformIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;

  const PlatformIcon(
    this.icon, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Platform.isMacOS) {
      return MacosIcon(icon, color: color);
    } else {
      return Icon(icon, color: color);
    }
  }
}
