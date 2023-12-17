import 'package:flutter_test/flutter_test.dart';
import 'package:friendlyscorer/repositories.dart';

void main() {
  group('answer player association repository', () {
    test('starts with no associations for answer UNUSED_ID_FOR_TESTING', () {
      const answerId = 'UNUSED_ANSWER_ID_FOR_TESTING';
      final repository = AnswerPlayerAssociationRepository();
      expect(repository.getPlayersWhoHaveChosenAnswer(answerId), isEmpty);
    });

    test(
        'emits an event when a player is associated with UNUSED_ID_FOR_TESTING',
        () {
      const answerId = 'UNUSED_ANSWER_ID_FOR_TESTING';
      const playerId = 'PLAYER_ID';
      final repository = AnswerPlayerAssociationRepository();
      final stream = repository.getPlayersWhoHaveChosenAnswerStream(answerId);
      expectLater(
        stream,
        emits([playerId]),
      );
      repository.addAssociation(playerId: playerId, answerId: answerId);
    });

    test(
        'returns answers when a player is associated with UNUSED_ID_FOR_TESTING',
        () {
      const answerId = 'UNUSED_ANSWER_ID_FOR_TESTING';
      const playerId = 'PLAYER_ID';
      final repository = AnswerPlayerAssociationRepository();
      expect(repository.getPlayersWhoHaveChosenAnswer(answerId), [playerId]);
    });
  });
}
