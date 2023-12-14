import 'package:flutter/material.dart';
import 'package:friendlyscorer/src/platform/palette.dart';
import 'package:friendlyscorer/src/platform/typography.dart';

class MaterialAnswerCandidateChip extends StatelessWidget {
  final String answer;

  const MaterialAnswerCandidateChip({
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

class MaterialResultDisplay extends StatelessWidget {
  final List<List<String>> results;
  final int? selectedAnswersIndex;
  final void Function(List<String> answerCandidates)? _onSelect;

  const MaterialResultDisplay({
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

  MapEntry<int, ListTile> _candidateToListRow(
      int rowIndex, List<String> answersInCandidate) {
    Widget? checkMark;
    if (rowIndex == selectedAnswersIndex) {
      checkMark = const Icon(Icons.check);
    }

    var chips = answersInCandidate
        .map((e) => MaterialAnswerCandidateChip(answer: e))
        .toList(growable: false);

    return MapEntry(
      rowIndex,
      ListTile(
        onTap: () => _onSelect?.call(answersInCandidate),
        title: Wrap(spacing: 4, children: chips),
        trailing: checkMark,
      ),
    );
  }
}
