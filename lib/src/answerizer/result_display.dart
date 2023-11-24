import 'package:flutter/cupertino.dart';

import '../tiles.dart';

class ResultDisplay extends StatelessWidget {
  final List<List<String>> results;
  final int? selectedAnswersIndex;
  final void Function(int answersIndex)? onSelect;

  const ResultDisplay({
    super.key,
    required this.results,
    this.selectedAnswersIndex,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoListSection(
          header: const Text('Parsed answers'),
          children: results
              .asMap()
              .map((key, value) {
                Widget? trailing;
                if (key == selectedAnswersIndex) {
                  trailing = const Icon(CupertinoIcons.check_mark);
                }
                var children = value
                    .map((e) => AnswerCircle(answer: e))
                    .toList(growable: false);
                return MapEntry(
                  key,
                  CupertinoListTile(
                    title: Wrap(
                      spacing: 4,
                      children: children,
                    ),
                    trailing: trailing,
                    onTap: () => onSelect?.call(key),
                  ),
                );
              })
              .values
              .toList(growable: false),
        ),
      ],
    );
  }
}
