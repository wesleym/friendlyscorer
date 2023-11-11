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
            SizedBox(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const PlayerTile(
                    child: Text('Brian'),
                  ),
                  const PlayerTile(
                    child: Text('Chip'),
                  ),
                  const PlayerTile(
                    child: Text('Kathy'),
                  ),
                  const PlayerTile(
                    child: Text('Lex'),
                  ),
                  const PlayerTile(
                    child: Text('Shelley'),
                  ),
                  const PlayerTile(
                    child: Text('CarlGPT'),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    onPressed: () {},
                    child: const Icon(CupertinoIcons.add),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Wrap(
                children: [
                  const AnswerTile(
                    child: Text('Steve Martin'),
                  ),
                  const AnswerTile(
                    child: Text('Taylor Swift'),
                  ),
                  const AnswerTile(
                    child: Text('Eddie Murphy'),
                  ),
                  const AnswerTile(
                    child: Text('Chevy Chase'),
                  ),
                  ...[
                    'Robert Downey Jr.',
                    'Lin-Manuel Miranda',
                    'Paul Giamatti',
                    'Justin Timberlake',
                    'Steve Martin',
                    'Tina Fey',
                    'Paul Simon',
                    'Tom Hanks',
                    'Taylor Swift',
                    'Taylor Lautner',
                    'Britney Spears',
                    'Hugh Jackman',
                    'Elon Musk',
                    'Ruth Gordon',
                    'Charles Barkley',
                    'Magnus Carlsen',
                  ].map(
                    (s) => AnswerTile(
                      child: Text(s),
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    child: const Icon(CupertinoIcons.add),
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    child: const Icon(CupertinoIcons.clear),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...[
                    'Buck Henry',
                    'Alec Baldwin',
                    'Steve Martin',
                    'Athlete',
                  ].map(
                    (s) => RuleTile(
                      child: Text(s),
                    ),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    onPressed: () {},
                    child: const Icon(CupertinoIcons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
