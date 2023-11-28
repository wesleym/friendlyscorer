import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

import '../tiles.dart';

class CompactResultDisplay extends StatelessWidget {
  final List<List<String>> _results;
  final void Function(List<String> answerCandidates)? _onSelect;

  const CompactResultDisplay({
    super.key,
    required List<List<String>> results,
    void Function(List<String> answerCandidates)? onSelect,
  })  : _results = results,
        _onSelect = onSelect;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return MaterialCompactResultDisplay(
        results: _results,
        onSelect: _onSelect,
      );
    }

    if (Platform.isIOS) {
      return CupertinoCompactResultDisplay(
        results: _results,
        onSelect: _onSelect,
      );
    }

    if (Platform.isMacOS) {
      return MacCompactResultDisplay(
        results: _results,
        onSelect: _onSelect,
      );
    }

    return MaterialCompactResultDisplay(
      results: _results,
      onSelect: _onSelect,
    );
  }
}

class MaterialCompactResultDisplay extends StatelessWidget {
  final List<List<String>> results;
  final int? selectedAnswersIndex;
  final void Function(List<String> answerCandidates)? _onSelect;

  const MaterialCompactResultDisplay({
    super.key,
    required this.results,
    this.selectedAnswersIndex,
    void Function(List<String>)? onSelect,
  }) : _onSelect = onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: results
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
                onTap: () => _onSelect?.call(value),
              ),
            );
          })
          .values
          .toList(growable: false),
    );
  }
}

class CupertinoCompactResultDisplay extends StatelessWidget {
  final List<List<String>> results;
  final int? selectedAnswersIndex;
  final void Function(List<String> answerCandidates)? _onSelect;

  const CupertinoCompactResultDisplay({
    super.key,
    required this.results,
    this.selectedAnswersIndex,
    void Function(List<String>)? onSelect,
  }) : _onSelect = onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                onTap: () => _onSelect?.call(value),
              ),
            );
          })
          .values
          .toList(growable: false),
    );
  }
}

class MacCompactResultDisplay extends StatelessWidget {
  final List<List<String>> results;
  final int? selectedAnswersIndex;
  final void Function(List<String> answerCandidates)? _onSelect;

  const MacCompactResultDisplay({
    super.key,
    required this.results,
    this.selectedAnswersIndex,
    void Function(List<String>)? onSelect,
  }) : _onSelect = onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: results
          .asMap()
          .map((key, value) {
            var children = value
                .map((e) => MacAnswerCircle(answer: e))
                .toList(growable: false);
            return MapEntry(
              key,
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: PushButton(
                  controlSize: ControlSize.regular,
                  secondary: true,
                  onPressed: () => _onSelect?.call(value),
                  child: Wrap(
                    spacing: 4,
                    children: children,
                  ),
                ),
              ),
            );
          })
          .values
          .toList(growable: false),
    );
  }
}
