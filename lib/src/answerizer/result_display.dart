import 'package:flutter/cupertino.dart';

import '../tiles.dart';

class ResultDisplay extends StatelessWidget {
  final List<List<String>> results;

  const ResultDisplay({
    super.key,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoListSection(
          header: const Text('Parsed answers'),
          children: results.map((e) {
            return CupertinoListTile(
              title: Wrap(
                spacing: 4,
                children: e
                    .map((e) => AnswerCircle(answer: e))
                    .toList(growable: false),
              ),
            );
          }).toList(growable: false),
        ),
      ],
    );
  }
}
