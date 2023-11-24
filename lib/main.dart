import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:macos_ui/macos_ui.dart';

import 'src/home_page.dart';

void main() async {
  if (kIsWeb) {
    runApp(const FriendlyWebApp());
    return;
  }

  if (Platform.isMacOS) {
    await _configureMacosWindowUtils();
    runApp(const FriendlyMacApp());
    return;
  }

  runApp(const FriendlyIOSApp());
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
      home: HomePage(),
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

class FriendlyWebApp extends StatelessWidget {
  const FriendlyWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: HomePage(),
    );
  }
}
