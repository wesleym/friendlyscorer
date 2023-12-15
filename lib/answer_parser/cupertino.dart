import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/platform/palette.dart';
import 'package:friendlyscorer/platform/typography.dart';

class CupertinoAnswerCandidateChip extends StatelessWidget {
  final String answer;

  const CupertinoAnswerCandidateChip({
    super.key,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: answerCandidateChipColors(),
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

class CupertinoResultDisplay extends StatelessWidget {
  final List<List<String>> results;
  final int? selectedAnswersIndex;
  final void Function(List<String> answerCandidates)? _onSelect;

  const CupertinoResultDisplay({
    super.key,
    required this.results,
    this.selectedAnswersIndex,
    void Function(List<String>)? onSelect,
  }) : _onSelect = onSelect;

  @override
  Widget build(BuildContext context) {
    var candidatesByRowIndex = results.asMap();
    var rows = candidatesByRowIndex
        .map(_candidateToListRow)
        .values
        .toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  MapEntry<int, CupertinoListTile> _candidateToListRow(
      int rowIndex, List<String> answersInCandidate) {
    Widget? trailing;
    if (rowIndex == selectedAnswersIndex) {
      trailing = const Icon(CupertinoIcons.check_mark);
    }

    var chips = answersInCandidate
        .map((e) => CupertinoAnswerCandidateChip(answer: e))
        .toList(growable: false);

    return MapEntry(
      rowIndex,
      CupertinoListTile(
        onTap: () => _onSelect?.call(answersInCandidate),
        title: Wrap(spacing: 4, children: chips),
        trailing: trailing,
      ),
    );
  }
}
