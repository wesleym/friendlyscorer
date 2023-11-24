import 'package:flutter/cupertino.dart';

import 'answerizer/answerizer.dart';
import 'answerizer/result_display.dart';
import 'data/repository.dart';

class InputSheet extends StatefulWidget {
  final ScrollController? _scrollController;

  const InputSheet({
    super.key,
    ScrollController? scrollController,
  }) : _scrollController = scrollController;

  @override
  State<InputSheet> createState() => _InputSheetState();
}

class _InputSheetState extends State<InputSheet> {
  late final PlayerRepository _playerRepository;
  var _answerValue = '';
  String? _selectedPlayerId;

  @override
  void initState() {
    super.initState();

    _playerRepository = PlayerRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

    return CupertinoPopupSurface(
      child: SingleChildScrollView(
        controller: widget._scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Answers',
                      style: theme.textTheme.navLargeTitleTextStyle,
                    ),
                  ),
                  CupertinoButton(
                    child: const Icon(CupertinoIcons.chevron_down),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
                      if (snapshot.data!.isNotEmpty)
                        Expanded(
                          child: CupertinoSlidingSegmentedControl(
                            groupValue: _selectedPlayerId,
                            onValueChanged: (value) {
                              setState(() {
                                _selectedPlayerId = value;
                              });
                            },
                            children: snapshot.data!.asMap().map(
                                  (key, value) => MapEntry(
                                    value.id,
                                    Text(value.name),
                                  ),
                                ),
                          ),
                        ),
                      CupertinoButton(
                        onPressed: _selectedPlayerId == null
                            ? null
                            : () {
                                setState(() {
                                  _selectedPlayerId = null;
                                });
                              },
                        child: const Icon(CupertinoIcons.clear_circled),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              CupertinoButton.filled(
                child: const Text('Add to scoreboard'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
