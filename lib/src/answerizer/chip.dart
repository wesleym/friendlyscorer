import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/platform/typography.dart';

/* 
The answerizer splits input text into a number of answers. For example:

"foo, bar, baz" -> "foo", "bar", and "baz"

To visually indicate that these are three separate answers, each answer is
represented by an answer candidate chip widget. This gives them a shape and
gradient background so they are visually separated.
*/

class MaterialAnswerCandidateChip extends StatelessWidget {
  final String answer;

  const MaterialAnswerCandidateChip({
    super.key,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CupertinoColors.systemGreen,
            CupertinoColors.activeOrange,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        answer,
        style: bodyStyle(context),
      ),
    );
  }
}

class CupertinoAnswerCandidateChip extends StatelessWidget {
  final String answer;

  const CupertinoAnswerCandidateChip({
    super.key,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CupertinoColors.systemGreen,
            CupertinoColors.activeOrange,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        answer,
        style: bodyStyle(context),
      ),
    );
  }
}

class MacAnswerCandidateChip extends StatelessWidget {
  final String answer;

  const MacAnswerCandidateChip({
    super.key,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CupertinoColors.systemGreen,
            CupertinoColors.activeOrange,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.all(1),
      child: Text(answer),
    );
  }
}
