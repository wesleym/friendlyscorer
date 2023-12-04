import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/src/answerizer/answerizer.dart';
import 'package:friendlyscorer/src/answerizer/compact_display.dart';
import 'package:friendlyscorer/src/platform/palette.dart';
import 'package:friendlyscorer/src/platform/text_field.dart';
import 'package:friendlyscorer/src/platform/typography.dart';

class NewInnerAnswerTile extends StatefulWidget {
  final void Function(List<String> candidates)? _onAddAnswers;

  const NewInnerAnswerTile({
    super.key,
    void Function(List<String> candidates)? onAddAnswers,
  }) : _onAddAnswers = onAddAnswers;

  @override
  State<NewInnerAnswerTile> createState() => _NewInnerAnswerTileState();
}

class _NewInnerAnswerTileState extends State<NewInnerAnswerTile> {
  final _controller = TextEditingController();

  var _candidates = <List<String>>[];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _candidates = answerizer(_controller.value.text);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BoxShadow>? shadows;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(2),
      constraints: const BoxConstraints(minHeight: 140),
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: platformAnswerColor(context),
        shadows: shadows,
      ),
      child: Column(
        children: [
          CompactResultDisplay(
            results: _candidates,
            onSelect: _onSelectAnswer,
          ),
          const SizedBox(height: 8),
          PlatformInvisibleTextField(
            controller: _controller,
            style: answerTileHeading(context),
            placeholder: 'Answer(s)',
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            onSubmitted: (_) {
              if (_candidates.isEmpty) return;
              _onSelectAnswer(_candidates.first);
            },
          ),
        ],
      ),
    );
  }

  void _onSelectAnswer(List<String> answerCandidates) {
    widget._onAddAnswers?.call(answerCandidates);
    _controller.clear();
  }
}
