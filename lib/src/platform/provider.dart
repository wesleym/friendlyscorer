import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

enum FriendlyPlatform { iOS, macOS, other }

FriendlyPlatform detectPlatform() {
  if (!kIsWeb && Platform.isIOS) {
    return FriendlyPlatform.iOS;
  } else if (!kIsWeb && Platform.isMacOS) {
    return FriendlyPlatform.macOS;
  } else {
    return FriendlyPlatform.other;
  }
}

class PlatformProvider extends InheritedWidget {
  final FriendlyPlatform platform;

  PlatformProvider({
    super.key,
    required super.child,
    FriendlyPlatform? platformOverride,
  }) : platform = platformOverride ?? detectPlatform();

  static PlatformProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PlatformProvider>();
  }

  static PlatformProvider of(BuildContext context) {
    final PlatformProvider? result = maybeOf(context);
    assert(result != null, 'No PlatformProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(PlatformProvider oldWidget) {
    return platform != oldWidget.platform;
  }
}
