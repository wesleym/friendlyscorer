import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'src/home_page.dart';

void main() {
  if (kIsWeb) {
    runApp(const FriendlyWebApp());
    return;
  }

  if (Platform.isMacOS) {
    runApp(const FriendlyMacApp());
    return;
  }

  runApp(const FriendlyIOSApp());
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
    return const CupertinoApp(
      home: HomePage(),
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
