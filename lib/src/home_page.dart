import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/data/repository.dart';
import 'package:friendlyscorer/src/tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AnswerRepository _answerRepository;

  @override
  void initState() {
    super.initState();

    _answerRepository = AnswerRepository.instance;
  }

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
              child: StreamBuilder(
                  initialData: _answerRepository.answers,
                  stream: _answerRepository.answerStream,
                  builder: (context, snapshot) {
                    return Wrap(
                      children: [
                        ...snapshot.data!.map(
                          (s) => AnswerTile(
                            key: ValueKey(s.id),
                            child: Text(s.text),
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
                    );
                  }),
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
