import 'package:flutter/cupertino.dart';

import '../tiles.dart';

class ResultDisplay extends StatelessWidget {
  const ResultDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoListSection(
          header: const Text('Parsed answers'),
          children: const [
            CupertinoListTile(
              trailing: Icon(CupertinoIcons.check_mark),
              title: Wrap(
                spacing: 4,
                children: [
                  AnswerCircle(
                      answer:
                          'Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy'),
                ],
              ),
            ),
            CupertinoListTile(
              title: Wrap(
                spacing: 4,
                children: [
                  AnswerCircle(answer: 'Britney Spears'),
                  AnswerCircle(answer: 'Eddie Murphy'),
                  AnswerCircle(answer: 'Justin Timberlake'),
                  AnswerCircle(answer: 'Magnus Carlsen'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
