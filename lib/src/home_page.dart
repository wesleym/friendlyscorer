import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friendlyscorer/src/answer/tiles.dart';
import 'package:friendlyscorer/src/data/models.dart';
import 'package:friendlyscorer/src/editing/editing.dart';
import 'package:friendlyscorer/src/platform/button.dart';
import 'package:friendlyscorer/src/platform/icon_button.dart';
import 'package:friendlyscorer/src/platform/icons.dart';
import 'package:friendlyscorer/src/platform/modal.dart';
import 'package:friendlyscorer/src/player/palette.dart';
import 'package:friendlyscorer/src/player/tiles.dart';
import 'package:friendlyscorer/src/rule/tiles.dart';
import 'package:macos_ui/macos_ui.dart';

import 'data/repository.dart';

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
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: const HomePageBody(),
      ),
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
                child: const Text('Edit')),
          ],
        ),
        body: const HomePageBody(),
      ),
    );
  }
}

class MacHomePage extends StatefulWidget {
  const MacHomePage({super.key});

  @override
  State<MacHomePage> createState() => _MacHomePageState();
}

class _MacHomePageState extends State<MacHomePage> {
  var _editing = false;

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      child: Builder(builder: (context) {
        return EditingProvider(
          editing: _editing,
          child: MacosScaffold(
            toolBar: ToolBar(
              title: const Text('Friendly Scorer'),
              actions: [
                ToolBarIconButton(
                  label: 'Edit',
                  tooltipMessage: 'Edit',
                  icon: const MacosIcon(CupertinoIcons.pencil),
                  showLabel: false,
                  onPressed: () {
                    setState(() => _editing = !_editing);
                  },
                ),
              ],
            ),
            children: [
              ContentArea(
                builder: (context, scrollController) => const HomePageBody(),
              ),
            ],
          ),
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

  @override
  void initState() {
    super.initState();

    _answerRepository = AnswerRepository.instance;
    _playerRepository = PlayerRepository.instance;
    _ruleRepository = RuleRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    final editing = EditingProvider.of(context);
    Widget? clearButton;
    void Function(String answerId)? onDelete;
    if (editing.editing) {
      clearButton = PlatformButton(
        onPressed: _onClearAnswers,
        child: const Text(
          'Clear',
          style: TextStyle(color: CupertinoColors.destructiveRed),
        ),
      );
      onDelete = _onDeleteAnswer;
    }

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
                child: PlayerColumn(playerRepository: _playerRepository),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PlatformIcon(
                                PlatformIcons.answers,
                                color: CupertinoColors.inactiveGray,
                              ),
                              if (clearButton != null) clearButton,
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Wrap(children: [
                                ...snapshot.data!
                                    .map(
                                      (s) => AnswerTile(
                                        key: ValueKey(s.id),
                                        answer: s,
                                        onDelete: onDelete,
                                      ),
                                    )
                                    .toList(growable: false),
                                NewInnerAnswerTile(
                                  onAddAnswers: (candidates) {
                                    for (final a in candidates) {
                                      final answer = Answer(id: a, text: a);
                                      _answerRepository.add(answer);
                                    }
                                  },
                                ),
                              ]),
                            ),
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

  void _onClearAnswers() async {
    final delete = await presentPlatformDestructionConfirmation(
      context: context,
      title: const Text('Delete all answers'),
    );
    if (delete) {
      _answerRepository.clear();
    }
  }

  void _onDeleteAnswer(String answerId) => _answerRepository.remove(answerId);
}

class RuleColumn extends StatelessWidget {
  const RuleColumn({
    super.key,
    required RuleRepository ruleRepository,
  }) : _ruleRepository = ruleRepository;

  final RuleRepository _ruleRepository;

  @override
  Widget build(BuildContext context) {
    final editing = EditingProvider.of(context);
    Widget? clearButton;
    if (editing.editing) {
      clearButton = PlatformButton(
        onPressed: () => _onClearRules(context),
        child: const Text(
          'Clear',
          style: TextStyle(color: CupertinoColors.destructiveRed),
        ),
      );
    }

    return StreamBuilder(
      initialData: _ruleRepository.rules,
      stream: _ruleRepository.ruleStream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlatformIcon(
                  PlatformIcons.specialRules,
                  color: CupertinoColors.inactiveGray,
                ),
                if (clearButton != null) clearButton,
              ],
            ),
            const SizedBox(height: 8),
            ...snapshot.data!.map(
              (r) => Expanded(
                child: RuleTile(rule: r),
              ),
            ),
            NewRuleTile(onCreateRule: _onCreateRule),
          ],
        );
      },
    );
  }

  void _onClearRules(BuildContext context) async {
    final delete = await presentPlatformDestructionConfirmation(
      context: context,
      title: const Text('Delete all special rules?'),
    );
    if (delete) {
      _ruleRepository.clear();
    }
  }

  void _onCreateRule(String name) {
    final id = RuleIdVendor().next();
    _ruleRepository.add(
      Rule(id: id.toString(), text: name),
    );
  }
}

class PlayerColumn extends StatelessWidget {
  final PlayerRepository _playerRepository;

  const PlayerColumn({
    super.key,
    required PlayerRepository playerRepository,
  }) : _playerRepository = playerRepository;

  @override
  Widget build(BuildContext context) {
    final editing = EditingProvider.of(context);
    Widget? clearButton;
    if (editing.editing) {
      clearButton = PlatformButton(
        onPressed: () => _onClearPlayers(context),
        child: const Text(
          'Clear',
          style: TextStyle(color: CupertinoColors.destructiveRed),
        ),
      );
    }

    return StreamBuilder(
      initialData: _playerRepository.players,
      stream: _playerRepository.playerStream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlatformIcon(
                  PlatformIcons.players,
                  color: CupertinoColors.inactiveGray,
                ),
                if (clearButton != null) clearButton,
              ],
            ),
            const SizedBox(height: 8),
            ...snapshot.data!.map(
              (p) => Expanded(
                child: PlayerTile(player: p),
              ),
            ),
            NewPlayerTile(onCreatePlayer: _onCreatePlayer),
          ],
        );
      },
    );
  }

  void _onClearPlayers(BuildContext context) async {
    final delete = await presentPlatformDestructionConfirmation(
      context: context,
      title: const Text('Delete all players'),
    );
    if (delete) {
      _playerRepository.clear();
    }
  }

  void _onCreatePlayer(String name) {
    final id = PlayerIdVendor().next();
    _playerRepository.add(Player(
      id: id.toString(),
      name: name,
      color: playerColors[id % playerColors.length],
    ));
  }
}
