import 'package:flutter/cupertino.dart';

import 'data/repository.dart';
import 'tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AnswerRepository _answerRepository;
  late final PlayerRepository _playerRepository;

  @override
  void initState() {
    super.initState();

    _answerRepository = AnswerRepository.instance;
    _playerRepository = PlayerRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 120,
              child: StreamBuilder(
                  initialData: _playerRepository.players,
                  stream: _playerRepository.playerStream,
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...snapshot.data!.map(
                          (p) => Expanded(
                            child: PlayerTile(player: p),
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () {},
                          child: const Icon(CupertinoIcons.add),
                        ),
                      ],
                    );
                  }),
            ),
            Expanded(
              child: StreamBuilder(
                  initialData: _answerRepository.answers,
                  stream: _answerRepository.answerStream,
                  builder: (context, snapshot) {
                    return SingleChildScrollView(
                      child: Wrap(
                        children: [
                          ...snapshot.data!.map(
                            (s) => AnswerTile(
                              key: ValueKey(s.id),
                              answer: s,
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
                    (s) => Expanded(
                      child: RuleTile(
                        child: Text(s),
                      ),
                    ),
                  ),
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
