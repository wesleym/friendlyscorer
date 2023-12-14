import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class PlatformButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const PlatformButton({
    super.key,
    this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoButton(onPressed: onPressed, child: child);
    } else if (!kIsWeb && Platform.isMacOS) {
      return PushButton(
        controlSize: ControlSize.regular,
        onPressed: onPressed,
        secondary: true,
        child: child,
      );
    } else {
      return TextButton(onPressed: onPressed, child: child);
    }
  }
}
