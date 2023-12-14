import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/answer/repositories/answers.dart';
import 'package:friendlyscorer/src/answer/models.dart';
import 'package:friendlyscorer/src/answer/new_answer.dart';
import 'package:friendlyscorer/src/answer/tiles.dart';
import 'package:friendlyscorer/src/answer/trash.dart';
import 'package:friendlyscorer/src/home/editing.dart';
import 'package:friendlyscorer/src/platform/button.dart';
import 'package:friendlyscorer/src/platform/icon_button.dart';
import 'package:friendlyscorer/src/platform/icons.dart';
import 'package:friendlyscorer/src/platform/modal.dart';

class AnswerColumn extends StatelessWidget {
  final AnswerRepository _answerRepository;

  const AnswerColumn({
    super.key,
    required AnswerRepository answerRepository,
  }) : _answerRepository = answerRepository;

  @override
  Widget build(BuildContext context) {
    final editing = EditingProvider.of(context);
    Widget? clearButton;
    void Function(String answerId)? onDelete;
    final Widget bottomAnswer;
    if (editing.editing) {
      clearButton = PlatformButton(
        onPressed: () => _onClearAnswers(context),
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

    return StreamBuilder(
      initialData: _answerRepository.answers,
      stream: _answerRepository.answerStream,
      builder: (context, snapshot) {
        var answers = snapshot.data!;
        var answerTiles = answers.map((s) {
          return AnswerTile(
            key: ValueKey(s.id),
            answer: s,
            onDelete: onDelete,
          );
        });

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
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Wrap(children: [
                  ...answerTiles,
                  bottomAnswer,
                ]),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onClearAnswers(BuildContext context) async {
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
