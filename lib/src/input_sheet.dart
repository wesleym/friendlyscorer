import 'package:flutter/cupertino.dart';

import 'answerizer/answerizer.dart';
import 'answerizer/result_display.dart';
import 'data/repository.dart';

class InputSheet extends StatefulWidget {
  final ScrollController _scrollController;

  const InputSheet({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  @override
  State<InputSheet> createState() => _InputSheetState();
}

class _InputSheetState extends State<InputSheet> {
  late final PlayerRepository _playerRepository;
  var _answerValue = '';

  @override
  void initState() {
    super.initState();

    _playerRepository = PlayerRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: SingleChildScrollView(
        controller: widget._scrollController,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 4,
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        color: CupertinoColors.systemFill,
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                maxLines: 6,
                placeholder:
                    'Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy',
                onChanged: (value) {
                  setState(() {
                    _answerValue = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              ResultDisplay(results: answerizer(_answerValue)),
              const SizedBox(height: 16),
              StreamBuilder(
                initialData: _playerRepository.players,
                stream: _playerRepository.playerStream,
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoSlidingSegmentedControl(
                        groupValue: null,
                        onValueChanged: (value) {},
                        children: snapshot.data!.asMap().map(
                              (key, value) => MapEntry(
                                value.id,
                                Text(value.name),
                              ),
                            ),
                      ),
                      CupertinoButton(
                        onPressed: () {},
                        child: const Text('Clear player'),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              CupertinoButton.filled(
                child: const Text('Add answers'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
