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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 120,
                  child: PlayerColumn(
                    playerRepository: _playerRepository,
                  ),
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
                                      child: const Icon(CupertinoIcons.add),
                                      onPressed: () {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return DraggableScrollableSheet(
                                              initialChildSize: 1,
                                              controller:
                                                  _draggableScrollableController,
                                              builder:
                                                  (context, scrollController) {
                                                return InputSheet(
                                                    scrollController:
                                                        scrollController);
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    CupertinoButton(
                                      onPressed: _onClearAnswers,
                                      child: const Text(
                                        'Clear',
                                        style: TextStyle(
                                            color:
                                                CupertinoColors.destructiveRed),
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
                  child: RuleColumn(ruleRepository: _ruleRepository),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onClearAnswers() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                _answerRepository.clear();
                Navigator.of(context).pop();
              },
              isDestructiveAction: true,
              isDefaultAction: true,
              child: const Text('Remove all answers'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')),
        );
      },
    );
  }
}

class RuleColumn extends StatelessWidget {
  const RuleColumn({
    super.key,
    required RuleRepository ruleRepository,
  }) : _ruleRepository = ruleRepository;

  final RuleRepository _ruleRepository;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: _ruleRepository.rules,
      stream: _ruleRepository.ruleStream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Icon(CupertinoIcons.exclamationmark_square,
                  color: CupertinoColors.inactiveGray),
            ),
            const SizedBox(height: 8),
            ...snapshot.data!.map(
              (r) => Expanded(
                child: RuleTile(rule: r),
              ),
            ),
            Row(
              children: [
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.add),
                ),
                CupertinoButton(
                  onPressed: () => _onClearRules(context),
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: CupertinoColors.destructiveRed),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _onClearRules(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                _ruleRepository.clear();
                Navigator.of(context).pop();
              },
              isDestructiveAction: true,
              isDefaultAction: true,
              child: const Text('Clear all rules'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        );
      },
    );
  }
}

class PlayerColumn extends StatelessWidget {
  const PlayerColumn({
    super.key,
    required PlayerRepository playerRepository,
  }) : _playerRepository = playerRepository;

  final PlayerRepository _playerRepository;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
            Row(
              children: [
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.add),
                ),
                CupertinoButton(
                  onPressed: () => _onClearPlayers(context),
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: CupertinoColors.destructiveRed),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _onClearPlayers(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                _playerRepository.clear();
                Navigator.of(context).pop();
              },
              isDestructiveAction: true,
              isDefaultAction: true,
              child: const Text('Destroy all players'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        );
      },
    );
  }
}
