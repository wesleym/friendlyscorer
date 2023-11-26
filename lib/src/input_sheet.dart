import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friendlyscorer/src/data/models.dart';
import 'package:friendlyscorer/src/platform/icons.dart';

import 'answerizer/answerizer.dart';
import 'answerizer/result_display.dart';
import 'data/repository.dart';
import 'platform/filled_button.dart';
import 'platform/text_field.dart';
import 'player/picker.dart';

class PlatformInputSheet extends StatelessWidget {
  const PlatformInputSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const MaterialInputSheet();
    }

    if (Platform.isIOS) {
      return const CupertinoInputSheet();
    }

    return const MaterialInputSheet();
  }
}

class CupertinoInputSheet extends StatefulWidget {
  const CupertinoInputSheet({super.key});

  @override
  State<CupertinoInputSheet> createState() => _CupertinoInputSheetState();
}

class _CupertinoInputSheetState extends State<CupertinoInputSheet> {
  final _draggableScrollableController = DraggableScrollableController();

  late final AnswerRepository _answerRepository;

  int? _selectedAnswersIndex;
  var _answerValue = '';

  @override
  void initState() {
    super.initState();

    _answerRepository = AnswerRepository.instance;
  }

  @override
  void dispose() {
    _draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final answers = answerizer(_answerValue);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      controller: _draggableScrollableController,
      builder: (context, scrollController) {
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
                        onPressed: Navigator.of(context).pop,
                        child: Icon(PlatformIcons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  InputSheet(
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
      },
    );
  }
}

class MaterialInputSheet extends StatefulWidget {
  const MaterialInputSheet({super.key});

  @override
  State<MaterialInputSheet> createState() => _MaterialInputSheetState();
}

class _MaterialInputSheetState extends State<MaterialInputSheet> {
  late final AnswerRepository _answerRepository;

  int? _selectedAnswersIndex;
  var _answerValue = '';

  @override
  void initState() {
    super.initState();

    _answerRepository = AnswerRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final answers = answerizer(_answerValue);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Answers',
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
                IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.expand_more),
                ),
              ],
            ),
            const SizedBox(height: 16),
            InputSheet(
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
