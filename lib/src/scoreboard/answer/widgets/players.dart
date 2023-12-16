import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/src/scoreboard/answer/repositories/answer_player_asses.dart';
import 'package:friendlyscorer/src/scoreboard/player/chip.dart';
import 'package:friendlyscorer/src/scoreboard/player/repository.dart';

class AnswerTilePlayers extends StatelessWidget {
  final String answerId;
  final PlayerRepository _playerRepository;
  final AnswerPlayerAssociationRepository _answerPlayerAssociationRepository;

  const AnswerTilePlayers({
    super.key,
    required this.answerId,
    required PlayerRepository playerRepository,
    required AnswerPlayerAssociationRepository
        answerPlayerAssociationRepository,
  })  : _playerRepository = playerRepository,
        _answerPlayerAssociationRepository = answerPlayerAssociationRepository;

  @override
  Widget build(BuildContext context) {
    final playersWhoHaveChosenAnswer = _answerPlayerAssociationRepository
        .getPlayersWhoHaveChosenAnswer(answerId);
    final playersWhoHaveChosenAnswerStream = _answerPlayerAssociationRepository
        .getPlayersWhoHaveChosenAnswerStream(answerId);

    return StreamBuilder(
      initialData: playersWhoHaveChosenAnswer,
      stream: playersWhoHaveChosenAnswerStream,
      builder: (context, snapshot) {
        final players = snapshot.data!
            .map((id) => _playerRepository.getPlayerById(id)!)
            .toList()
          ..sort((a, b) => a.id.compareTo(b.id));

        final chips =
            players.map((p) => PlayerChip(player: p)).toList(growable: false);

        return Wrap(spacing: 4, children: chips);
      },
    );
  }
}
