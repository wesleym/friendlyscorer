import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/data/models.dart';

import 'answerizer/answerizer.dart';
import 'answerizer/result_display.dart';
import 'data/repository.dart';
import 'platform/filled_button.dart';
import 'platform/text_field.dart';
import 'player/picker.dart';

class CupertinoInputSheet extends StatefulWidget {
  final ScrollController? scrollController;

  const CupertinoInputSheet({super.key, this.scrollController});

  @override
  State<CupertinoInputSheet> createState() => _CupertinoInputSheetState();
}

class _CupertinoInputSheetState extends State<CupertinoInputSheet> {
  late final AnswerRepository _answerRepository;

  int? _selectedAnswersIndex;
  var _answerValue = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _answerRepository = AnswerRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final answers = answerizer(_answerValue);

    return CupertinoPopupSurface(
      child: SingleChildScrollView(
        controller: widget.scrollController,
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
              InputSheet(
                scrollController: widget.scrollController,
                answerValue: _answerValue,
                onAnswerValueChange: (a) {
                  setState(() => _answerValue = a);
                },
                selectedAnswersIndex: _selectedAnswersIndex,
                onSelectedAnswersIndex: (i) {
                  setState(() => _selectedAnswersIndex = i);
                },
              ),
              const SizedBox(height: 16),
              PlatformFilledTextButton(
                onPressed: _selectedAnswersIndex != null &&
                        _selectedAnswersIndex! < answers.length
                    ? () {
                        for (final answerText
                            in answers[_selectedAnswersIndex!]) {
                          _answerRepository.add(Answer(id: answerText));
                        }
                      }
                    : null,
                child: const Text('Add to scoreboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MacInputSheet extends StatefulWidget {
  final int? selectedAnswersIndex;
  final String answerValue;
  final void Function(String) _onAnswerValueChange;
  final void Function(int?) _onSelectedAnswersIndex;

  const MacInputSheet({
    super.key,
    required this.answerValue,
    required void Function(String) onAnswerValueChange,
    required this.selectedAnswersIndex,
    required void Function(int?) onSelectedAnswersIndex,
  })  : _onAnswerValueChange = onAnswerValueChange,
        _onSelectedAnswersIndex = onSelectedAnswersIndex;

  @override
  State<MacInputSheet> createState() => _MacInputSheetState();
}

class _MacInputSheetState extends State<MacInputSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InputSheet(
        answerValue: widget.answerValue,
        onAnswerValueChange: widget._onAnswerValueChange,
        selectedAnswersIndex: widget.selectedAnswersIndex,
        onSelectedAnswersIndex: widget._onSelectedAnswersIndex,
      ),
    );
  }
}

class InputSheet extends StatefulWidget {
  final int? selectedAnswersIndex;
  final String answerValue;
  final void Function(String) _onAnswerValueChange;
  final void Function(int?) _onSelectedAnswersIndex;

  const InputSheet({
    super.key,
    ScrollController? scrollController,
    required this.answerValue,
    required void Function(String) onAnswerValueChange,
    required this.selectedAnswersIndex,
    required void Function(int?) onSelectedAnswersIndex,
  })  : _onAnswerValueChange = onAnswerValueChange,
        _onSelectedAnswersIndex = onSelectedAnswersIndex;

  @override
  State<InputSheet> createState() => _InputSheetState();
}

class _InputSheetState extends State<InputSheet> {
  late final PlayerRepository _playerRepository;
  String? _selectedPlayerId;

  @override
  void initState() {
    super.initState();

    _playerRepository = PlayerRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    final answers = answerizer(widget.answerValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PlatformTextField(
          maxLines: 6,
          placeholder:
              'Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy',
          onChanged: widget._onAnswerValueChange,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
        ),
        const SizedBox(height: 16),
        ResultDisplay(
          results: answers,
          selectedAnswersIndex: widget.selectedAnswersIndex,
          onSelect: widget._onSelectedAnswersIndex,
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
      ],
    );
  }
}
