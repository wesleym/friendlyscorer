import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/platform.dart';
import 'package:friendlyscorer/src/scoreboard/home/editing.dart';
import 'package:friendlyscorer/src/scoreboard/rule/id.dart';
import 'package:friendlyscorer/src/scoreboard/rule/models.dart';
import 'package:friendlyscorer/src/scoreboard/rule/repository.dart';
import 'package:friendlyscorer/src/scoreboard/rule/tiles.dart';

class RuleColumn extends StatelessWidget {
  const RuleColumn({
    super.key,
    required RuleRepository ruleRepository,
  }) : _ruleRepository = ruleRepository;

  final RuleRepository _ruleRepository;

  @override
  Widget build(BuildContext context) {
    final editing = EditingProvider.of(context).editing;
    Widget? clearButton;
    if (editing) {
      clearButton = PlatformButton(
        onPressed: () => _onClearRules(context),
        child: Text(
          'Clear',
          style: TextStyle(color: PlatformColors.platformDanger),
        ),
      );
    }

    return StreamBuilder(
      initialData: _ruleRepository.rules,
      stream: _ruleRepository.ruleStream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlatformIcon(
                  PlatformIcons.specialRules,
                  color: PlatformColors.sectionHeadingColor,
                ),
                if (clearButton != null) clearButton,
              ],
            ),
            const SizedBox(height: 8),
            ...snapshot.data!.map(
              (r) => Expanded(
                child: RuleTile(rule: r),
              ),
            ),
            if (!editing) NewRuleTile(onCreateRule: _onCreateRule),
          ],
        );
      },
    );
  }

  void _onClearRules(BuildContext context) async {
    final delete = await presentPlatformDestructionConfirmation(
      context: context,
      title: const Text('Delete all special rules?'),
    );
    if (delete) {
      _ruleRepository.clear();
    }
  }

  void _onCreateRule(String name) {
    final id = RuleIdVendor().next();
    _ruleRepository.add(
      Rule(id: id.toString(), text: name),
    );
  }
}
