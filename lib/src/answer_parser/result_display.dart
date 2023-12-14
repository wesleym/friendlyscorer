import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friendlyscorer/src/answer_parser/cupertino.dart';
import 'package:friendlyscorer/src/answer_parser/mac.dart';
import 'package:friendlyscorer/src/answer_parser/material.dart';

class ResultDisplay extends StatelessWidget {
  final List<List<String>> _results;
  final void Function(List<String> answerCandidates)? _onSelect;

  const ResultDisplay({
    super.key,
    required List<List<String>> results,
    void Function(List<String> answerCandidates)? onSelect,
  })  : _results = results,
        _onSelect = onSelect;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoResultDisplay(
        results: _results,
        onSelect: _onSelect,
      );
    } else if (!kIsWeb && Platform.isMacOS) {
      return MacResultDisplay(
        results: _results,
        onSelect: _onSelect,
      );
    } else {
      return MaterialResultDisplay(
        results: _results,
        onSelect: _onSelect,
      );
    }
  }
}
