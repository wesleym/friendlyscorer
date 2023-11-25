import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class PlatformIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const PlatformIconButton({
    super.key,
    this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return IconButton(
        onPressed: onPressed,
        icon: child,
      );
    }

    if (Platform.isIOS) {
      return CupertinoButton(
        onPressed: onPressed,
        child: child,
      );
    }

    if (Platform.isMacOS) {
      return MacosIconButton(icon: child);
    }

    return FilledButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
