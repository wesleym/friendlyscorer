import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/answer/models.dart';
import 'package:friendlyscorer/answer/repositories/answers.dart';
import 'package:friendlyscorer/answer/widgets/new_answer.dart';
import 'package:friendlyscorer/answer/widgets/tile.dart';
import 'package:friendlyscorer/answer/widgets/trash.dart';
import 'package:friendlyscorer/home/editing.dart';
import 'package:friendlyscorer/platform/button.dart';
import 'package:friendlyscorer/platform/icon_button.dart';
import 'package:friendlyscorer/platform/icons.dart';
import 'package:friendlyscorer/platform/modal.dart';
import 'package:friendlyscorer/platform/palette.dart';

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
        child: Text(
          'Clear',
          style: TextStyle(color: platformDanger(context)),
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
                  color: sectionHeadingColor(),
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
