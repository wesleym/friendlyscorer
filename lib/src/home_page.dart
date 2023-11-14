import 'package:flutter/cupertino.dart';

import 'data/repository.dart';
import 'input_sheet.dart';
import 'tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AnswerRepository _answerRepository;
  late final PlayerRepository _playerRepository;
  late final RuleRepository _ruleRepository;
  late final DraggableScrollableController _draggableScrollableController;

  @override
  void initState() {
    super.initState();

    _answerRepository = AnswerRepository.instance;
    _playerRepository = PlayerRepository.instance;
    _ruleRepository = RuleRepository.instance;

    _draggableScrollableController = DraggableScrollableController();
  }

  @override
  void dispose() {
    _draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: Stack(
        children: [
          SafeArea(
            minimum: const EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  flex: 9,
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
                                  const Icon(CupertinoIcons.person_3_fill,
                                      color: CupertinoColors.inactiveGray),
                                  const SizedBox(height: 8),
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
                      const SizedBox(width: 16),
                      Expanded(
                        child: StreamBuilder(
                            initialData: _answerRepository.answers,
                            stream: _answerRepository.answerStream,
                            builder: (context, snapshot) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Icon(CupertinoIcons.text_bubble,
                                        color: CupertinoColors.inactiveGray),
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Wrap(
                                        children: snapshot.data!
                                            .map(
                                              (s) => AnswerTile(
                                                key: ValueKey(s.id),
                                                answer: s,
                                              ),
                                            )
                                            .toList(growable: false),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          CupertinoButton(
                                            onPressed: () {},
                                            child: const Text(
                                              'Clear',
                                              style: TextStyle(
                                                  color: CupertinoColors
                                                      .destructiveRed),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 120,
                        child: StreamBuilder(
                            initialData: _ruleRepository.rules,
                            stream: _ruleRepository.ruleStream,
                            builder: (context, snapshot) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                        CupertinoIcons.exclamationmark_square,
                                        color: CupertinoColors.inactiveGray),
                                  ),
                                  const SizedBox(height: 8),
                                  ...snapshot.data!.map(
                                    (r) => Expanded(
                                      child: RuleTile(rule: r),
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
                    ],
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            minChildSize: 0.1,
            initialChildSize: 0.1,
            controller: _draggableScrollableController,
            builder: (context, scrollController) =>
                InputSheet(scrollController: scrollController),
          ),
        ],
      ),
    );
  }
}
