import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/repositories.dart';
import 'package:friendlyscorer/src/scoreboard/answer/column.dart';
import 'package:friendlyscorer/src/scoreboard/player/column.dart';
import 'package:friendlyscorer/src/scoreboard/rule/column.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  late final AnswerRepository _answerRepository;
  late final PlayerRepository _playerRepository;
  late final RuleRepository _ruleRepository;

  @override
  void initState() {
    super.initState();

    _answerRepository = AnswerRepository();
    _playerRepository = PlayerRepository();
    _ruleRepository = RuleRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          minimum: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 140,
                child: PlayerColumn(playerRepository: _playerRepository),
              ),
              Expanded(
                child: AnswerColumn(answerRepository: _answerRepository),
              ),
              SizedBox(
                width: 140,
                child: RuleColumn(ruleRepository: _ruleRepository),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
