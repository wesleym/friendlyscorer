import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friendlyscorer/src/answerizer/answerizer.dart';
import 'package:friendlyscorer/src/data/models.dart';
import 'package:friendlyscorer/src/platform/button.dart';
import 'package:friendlyscorer/src/platform/icon_button.dart';
import 'package:friendlyscorer/src/platform/modal.dart';
import 'package:macos_ui/macos_ui.dart';

import 'data/repository.dart';
import 'input_sheet.dart';
import 'tiles.dart';

class CupertinoHomePage extends StatelessWidget {
  const CupertinoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: HomePageBody(),
    );
  }
}

class MaterialHomePage extends StatelessWidget {
  const MaterialHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomePageBody());
  }
}

class MacHomePage extends StatefulWidget {
  const MacHomePage({super.key});

  @override
  State<MacHomePage> createState() => _MacHomePageState();
}

class _MacHomePageState extends State<MacHomePage> {
  late final AnswerRepository _answerRepository;

  int? _selectedAnswersIndex;
  var _answerValue = '';

  @override
  void initState() {
    super.initState();

    _answerRepository = AnswerRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    final answers = answerizer(_answerValue);
    final selectedAnswersIndex = _selectedAnswersIndex;

    return MacosWindow(
      endSidebar: Sidebar(
        builder: (context, scrollController) => MacInputSheet(
          answerValue: _answerValue,
          onAnswerValueChange: (a) {
            setState(() => _answerValue = a);
          },
          selectedAnswersIndex: _selectedAnswersIndex,
          onSelectedAnswersIndex: (i) {
            setState(() => _selectedAnswersIndex = i);
          },
        ),
        bottom: PushButton(
          controlSize: ControlSize.regular,
          onPressed: selectedAnswersIndex != null &&
                  selectedAnswersIndex < answers.length
              ? () {
                  for (final answerText in answers[_selectedAnswersIndex!]) {
                    _answerRepository.add(Answer(
                      id: answerText,
                      text: answerText,
                    ));
                  }

                  setState(() {
                    _answerValue = '';
                    _selectedAnswersIndex = null;
                  });
                }
              : null,
          child: const Text('Add to scoreboard'),
        ),
        minWidth: 200,
      ),
      child: Builder(builder: (context) {
        return MacosScaffold(
          toolBar: ToolBar(
            title: const Text('Friendly Scorer'),
            actions: [
              ToolBarIconButton(
                label: 'Add answer',
                icon: const MacosIcon(CupertinoIcons.sidebar_right),
                showLabel: false,
                onPressed: () =>
                    MacosWindowScope.of(context).toggleEndSidebar(),
              ),
            ],
          ),
          children: [
            ContentArea(
              builder: (context, scrollController) => const HomePageBody(),
            ),
          ],
        );
      }),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
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
    return Stack(
      children: [
        SafeArea(
          minimum: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 140,
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: PlatformIcon(CupertinoIcons.text_bubble,
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
                                  PlatformIconButton(
                                    CupertinoIcons.add,
                                    onPressed: () {
                                      presentPlatformModal(
                                        context: context,
                                        builder: (context) {
                                          return PlatformInputSheet(
                                              draggableScrollableController:
                                                  _draggableScrollableController);
                                        },
                                      );
                                    },
                                  ),
                                  PlatformButton(
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
                width: 140,
                child: RuleColumn(ruleRepository: _ruleRepository),
              ),
            ],
          ),
        ),
      ],
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
              child: PlatformIcon(
                CupertinoIcons.exclamationmark_square,
                color: CupertinoColors.inactiveGray,
              ),
            ),
            const SizedBox(height: 8),
            ...snapshot.data!.map(
              (r) => Expanded(
                child: RuleTile(rule: r),
              ),
            ),
            Row(
              children: [
                PlatformIconButton(
                  CupertinoIcons.add,
                  onPressed: () {},
                ),
                PlatformButton(
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
            const PlatformIcon(CupertinoIcons.person_3_fill,
                color: CupertinoColors.inactiveGray),
            const SizedBox(height: 8),
            ...snapshot.data!.map(
              (p) => Expanded(
                child: PlayerTile(player: p),
              ),
            ),
            Row(
              children: [
                PlatformIconButton(
                  CupertinoIcons.add,
                  onPressed: () {},
                ),
                PlatformButton(
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
