import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class PlatformFilledTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const PlatformFilledTextButton({
    super.key,
    this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return FilledButton(
        onPressed: onPressed,
        child: child,
      );
    }

    if (Platform.isIOS) {
      return CupertinoButton.filled(
        onPressed: onPressed,
        child: child,
      );
    }

    if (Platform.isMacOS) {
      return PushButton(
        controlSize: ControlSize.regular,
        child: child,
      );
    }

    return FilledButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
