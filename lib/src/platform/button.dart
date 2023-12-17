import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friendlyscorer/platform.dart';
import 'package:macos_ui/macos_ui.dart';

/// A bordered push button labeled with text in an appropriate style for the
/// current platform.
///
/// The button will not be styled to be or act like the default button.
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
    final platform = PlatformProvider.of(context).platform;

    switch (platform) {
      case FriendlyPlatform.iOS:
        return CupertinoButton(onPressed: onPressed, child: child);
      case FriendlyPlatform.macOS:
        return PushButton(
          controlSize: ControlSize.regular,
          onPressed: onPressed,
          secondary: true,
          child: child,
        );
      default:
        return TextButton(onPressed: onPressed, child: child);
    }
  }
}
