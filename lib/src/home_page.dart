import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/tiles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('👯'),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                const PlayerTile(
                  child: Text('CarlGPT'),
                ),
                const PlayerTile(
                  child: Text('Shelley'),
                ),
                const PlayerTile(
                  child: Text('Brian'),
                ),
                const PlayerTile(
                  child: Text('Kathy'),
                ),
                const PlayerTile(
                  child: Text('Chip'),
                ),
                const Spacer(),
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.add),
                ),
              ],
            ),
            const Column(
              children: [
                AnswerTile(
                  child: Text('aaa'),
                ),
                AnswerTile(
                  child: Text('aaa'),
                ),
                AnswerTile(
                  child: Text('aaa'),
                ),
                AnswerTile(
                  child: Text('aaa'),
                ),
              ],
            ),
            Column(
              children: [
                const RuleTile(
                  child: Text('aaa'),
                ),
                const RuleTile(
                  child: Text('aaa'),
                ),
                const RuleTile(
                  child: Text('aaa'),
                ),
                const RuleTile(
                  child: Text('aaa'),
                ),
                const Spacer(),
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
