import 'package:flutter/material.dart';
import 'package:friendlyscorer/src/scoreboard/home/editing.dart';
import 'package:friendlyscorer/src/scoreboard/home/home_page.dart';

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

class MaterialHomePage extends StatefulWidget {
  const MaterialHomePage({super.key});

  @override
  State<MaterialHomePage> createState() => _MaterialHomePageState();
}

class _MaterialHomePageState extends State<MaterialHomePage> {
  var _editing = false;

  @override
  Widget build(BuildContext context) {
    return EditingProvider(
      editing: _editing,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Friendly Scorer'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _editing = !_editing);
              },
              child: const Text('Edit'),
            ),
          ],
        ),
        body: const HomePageBody(),
      ),
    );
  }
}
