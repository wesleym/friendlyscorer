import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/answer/models.dart';
import 'package:friendlyscorer/src/answer/new_answer.dart';
import 'package:friendlyscorer/src/answer/repository.dart';
import 'package:friendlyscorer/src/answer/tiles.dart';
import 'package:friendlyscorer/src/answer/trash.dart';
import 'package:friendlyscorer/src/editing/editing.dart';
import 'package:friendlyscorer/src/platform/button.dart';
import 'package:friendlyscorer/src/platform/icon_button.dart';
import 'package:friendlyscorer/src/platform/icons.dart';
import 'package:friendlyscorer/src/platform/modal.dart';
import 'package:friendlyscorer/src/player/column.dart';
import 'package:friendlyscorer/src/player/repository.dart';
import 'package:friendlyscorer/src/rule/column.dart';
import 'package:friendlyscorer/src/rule/repository.dart';

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

    _answerRepository = AnswerRepository();
    _playerRepository = PlayerRepository();
    _ruleRepository = RuleRepository();
  }

  @override
  Widget build(BuildContext context) {
    final editing = EditingProvider.of(context);
    Widget? clearButton;
    void Function(String answerId)? onDelete;
    final Widget bottomAnswer;
    if (editing.editing) {
      clearButton = PlatformButton(
        onPressed: _onClearAnswers,
        child: const Text(
          'Clear',
          style: TextStyle(color: CupertinoColors.destructiveRed),
        ),
      );
      onDelete = _onDeleteAnswer;
      bottomAnswer = TrashTile(onDeleteAnswer: _onDeleteAnswer);
    } else {
      bottomAnswer = NewInnerAnswerTile(
        onAddAnswers: (candidates) {
          for (final a in candidates) {
            final answer = Answer(id: a, text: a);
            _answerRepository.add(answer);
          }
        },
      );
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
                              primary: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 48),
                              child: Wrap(children: [
                                ...snapshot.data!.map(
                                  (s) => AnswerTile(
                                    key: ValueKey(s.id),
                                    answer: s,
                                    onDelete: onDelete,
                                  ),
                                ),
                                bottomAnswer,
                              ]),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
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
