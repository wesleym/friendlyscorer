import 'package:flutter/cupertino.dart';

import 'answerizer/answerizer.dart';
import 'answerizer/result_display.dart';
import 'data/repository.dart';
import 'platform/filled_button.dart';
import 'platform/text_field.dart';
import 'player/picker.dart';

class CupertinoInputSheet extends StatelessWidget {
  final ScrollController? scrollController;

  const CupertinoInputSheet({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

    return CupertinoPopupSurface(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
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
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              InputSheet(scrollController: scrollController),
            ],
          ),
        ),
      ),
    );
  }
}

class MacInputSheet extends StatelessWidget {
  const MacInputSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: InputSheet(),
    );
  }
}

class InputSheet extends StatefulWidget {
  const InputSheet({
    super.key,
    ScrollController? scrollController,
  });

  @override
  State<InputSheet> createState() => _InputSheetState();
}

class _InputSheetState extends State<InputSheet> {
  late final PlayerRepository _playerRepository;
  var _answerValue = '';
  String? _selectedPlayerId;
  int? _selectedAnswersIndex;

  @override
  void initState() {
    super.initState();

    _playerRepository = PlayerRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    var answers = answerizer(_answerValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PlatformTextField(
          maxLines: 6,
          placeholder:
              'Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy',
          onChanged: (value) {
            setState(() => _answerValue = value);
          },
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
        ),
        const SizedBox(height: 16),
        ResultDisplay(
          results: answers,
          selectedAnswersIndex: _selectedAnswersIndex,
          onSelect: (answersIndex) => setState(() {
            _selectedAnswersIndex = answersIndex;
          }),
        ),
        const SizedBox(height: 16),
        StreamBuilder(
          initialData: _playerRepository.players,
          stream: _playerRepository.playerStream,
          builder: (context, snapshot) {
            return PlayerPicker(
              players: snapshot.data!,
              selectedPlayerId: _selectedPlayerId,
              onSelectPlayer: (playerId) {
                setState(() => _selectedPlayerId = playerId);
              },
            );
          },
        ),
        const SizedBox(height: 16),
        PlatformFilledTextButton(
          onPressed: _selectedAnswersIndex != null &&
                  _selectedAnswersIndex! < answers.length
              ? () {}
              : null,
          child: const Text('Add to scoreboard'),
        ),
      ],
    );
  }
}
