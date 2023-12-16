import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:macos_ui/macos_ui.dart';

/// An Icon that presents the [icon] data at an appropriate size and shape for
/// the current platform.
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
