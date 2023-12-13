import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friendlyscorer/src/home_page.dart';
import 'package:macos_ui/macos_ui.dart';

void main() async {
  if (kIsWeb) {
    runApp(const FriendlyMaterialApp());
    return;
  }

  if (Platform.isIOS) {
    runApp(const FriendlyIOSApp());
    return;
  }

  if (Platform.isMacOS) {
    await _configureMacosWindowUtils();
    runApp(const FriendlyMacApp());
    return;
  }

  runApp(const FriendlyMaterialApp());
}

/// This method initializes macos_window_utils and styles the window.
Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig(
    toolbarStyle: NSWindowToolbarStyle.unified,
  );
  await config.apply();
}

class FriendlyIOSApp extends StatelessWidget {
  const FriendlyIOSApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Friendly Scorer',
      home: CupertinoHomePage(),
    );
  }
}

class FriendlyMacApp extends StatelessWidget {
  const FriendlyMacApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      home: const MacHomePage(),
    );
  }
}

class FriendlyMaterialApp extends StatelessWidget {
  const FriendlyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MaterialHomePage(),
      darkTheme: ThemeData.dark(),
    );
  }
}
