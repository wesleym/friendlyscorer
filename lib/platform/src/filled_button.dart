import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

/// A bordered, filled push button labeled with text in an appropriate style for
/// the current platform.
///
/// The button will be styled to be and act like the default button for its
/// current context, such as OK in a confirmation dialog or a Submit button on a
/// form.
class PlatformFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const PlatformFilledButton({
    super.key,
    this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoButton.filled(
        onPressed: onPressed,
        child: child,
      );
    } else if (!kIsWeb && Platform.isMacOS) {
      return PushButton(
        controlSize: ControlSize.regular,
        child: child,
      );
    } else {
      return FilledButton(
        onPressed: onPressed,
        child: child,
      );
    }
  }
}
