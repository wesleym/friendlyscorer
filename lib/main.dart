import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/scoreboard.dart';
import 'package:friendlyscorer/src/platform/provider.dart';

void main() async {
  final Widget app;
  if (!kIsWeb && Platform.isIOS) {
    app = const FriendlyCupertinoApp();
  } else if (!kIsWeb && Platform.isMacOS) {
    await configureMacosWindowUtils();
    app = const FriendlyMacApp();
  } else {
    app = const FriendlyMaterialApp();
  }

  runApp(PlatformProvider(child: app));
}
