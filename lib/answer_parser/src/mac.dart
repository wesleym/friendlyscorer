import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/platform/platform.dart';
import 'package:macos_ui/macos_ui.dart';

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
          colors: PlatformColors.answerCandidateChipColors,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.all(1),
      child: Text(answer),
    );
  }
}

class MacResultDisplay extends StatelessWidget {
  final List<List<String>> results;
  final int? selectedAnswersIndex;
  final void Function(List<String> answerCandidates)? _onSelect;

  const MacResultDisplay({
    super.key,
    required this.results,
    this.selectedAnswersIndex,
    void Function(List<String>)? onSelect,
  }) : _onSelect = onSelect;

  @override
  Widget build(BuildContext context) {
    var candidatesByRowIndex = results.asMap();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: candidatesByRowIndex
          .map(_candidateToListRow)
          .values
          .toList(growable: false),
    );
  }

  MapEntry<int, Padding> _candidateToListRow(
      int rowIndex, List<String> answersInCandidate) {
    var chips = answersInCandidate
        .map((e) => MacAnswerCandidateChip(answer: e))
        .toList(growable: false);

    return MapEntry(
      rowIndex,
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: PushButton(
          controlSize: ControlSize.regular,
          secondary: true,
          onPressed: () => _onSelect?.call(answersInCandidate),
          child: Wrap(spacing: 4, children: chips),
        ),
      ),
    );
  }
}
