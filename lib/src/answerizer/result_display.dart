import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

import '../tiles.dart';

class ResultDisplay extends StatelessWidget {
  final List<List<String>> _results;
  final int? selectedAnswersIndex;
  final void Function(int? index)? _onSelect;

  const ResultDisplay({
    super.key,
    required List<List<String>> results,
    this.selectedAnswersIndex,
    void Function(int? index)? onSelect,
  })  : _results = results,
        _onSelect = onSelect;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return MaterialResultDisplay(
        results: _results,
        onSelect: _onSelect,
        selectedAnswersIndex: selectedAnswersIndex,
      );
    }

    if (Platform.isIOS) {
      return CupertinoResultDisplay(
        results: _results,
        onSelect: _onSelect,
        selectedAnswersIndex: selectedAnswersIndex,
      );
    }

    if (Platform.isMacOS) {
      return MacResultDisplay(
        results: _results,
        onSelect: _onSelect,
        selectedAnswersIndex: selectedAnswersIndex,
      );
    }

    return MaterialResultDisplay(
      results: _results,
      onSelect: _onSelect,
      selectedAnswersIndex: selectedAnswersIndex,
    );
  }
}

class MaterialResultDisplay extends StatelessWidget {
  final List<List<String>> results;
  final int? selectedAnswersIndex;
  final void Function(int answersIndex)? onSelect;

  const MaterialResultDisplay({
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
        const Text('Parsed answers'),
        ...results
            .asMap()
            .map((key, value) {
              Widget? trailing;
              if (key == selectedAnswersIndex) {
                trailing = const Icon(Icons.check);
              }
              var children = value
                  .map((e) => MaterialAnswerCircle(answer: e))
                  .toList(growable: false);
              return MapEntry(
                key,
                ListTile(
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
      ],
    );
  }
}

class CupertinoResultDisplay extends StatelessWidget {
  final List<List<String>> results;
  final int? selectedAnswersIndex;
  final void Function(int answersIndex)? onSelect;

  const CupertinoResultDisplay({
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
                    .map((e) => CupertinoAnswerCircle(answer: e))
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

class MacResultDisplay extends StatelessWidget {
  final List<List<String>> results;
  final int? selectedAnswersIndex;
  final void Function(int answersIndex)? onSelect;

  const MacResultDisplay({
    super.key,
    required this.results,
    this.selectedAnswersIndex,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Parsed answers'),
        ...results
            .asMap()
            .map((key, value) {
              var children = value
                  .map((e) => MacAnswerCircle(answer: e))
                  .toList(growable: false);
              return MapEntry(
                key,
                Row(
                  children: [
                    MacosRadioButton(
                      value: key,
                      groupValue: selectedAnswersIndex,
                      onChanged: (value) => onSelect?.call(key),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: GestureDetector(
                        onTap: () => onSelect?.call(key),
                        behavior: HitTestBehavior.opaque,
                        child: Wrap(
                          spacing: 4,
                          children: children,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
            .values
            .toList(growable: false),
      ],
    );
  }
}
