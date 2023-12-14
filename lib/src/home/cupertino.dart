import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/home/editing.dart';
import 'package:friendlyscorer/src/home/home_page.dart';
import 'package:friendlyscorer/src/platform/palette.dart';

class FriendlyCupertinoApp extends StatelessWidget {
  const FriendlyCupertinoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Friendly Scorer',
      home: CupertinoHomePage(),
    );
  }
}

class CupertinoHomePage extends StatefulWidget {
  const CupertinoHomePage({super.key});

  @override
  State<CupertinoHomePage> createState() => _CupertinoHomePageState();
}

class _CupertinoHomePageState extends State<CupertinoHomePage> {
  var _editing = false;

  @override
  Widget build(BuildContext context) {
    return EditingProvider(
      editing: _editing,
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Friendly Scorer'),
          trailing: CupertinoButton(
              onPressed: () {
                setState(() => _editing = !_editing);
              },
              child: const Icon(CupertinoIcons.pencil)),
        ),
        backgroundColor: platformCanvasColor(context),
        child: const HomePageBody(),
      ),
    );
  }
}
