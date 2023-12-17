import 'package:flutter_test/flutter_test.dart';
import 'package:friendlyscorer/repositories.dart';

void main() {
  group('answer player association repository', () {
    const answerId = 'UNUSED_ANSWER_ID_FOR_TESTING';
    const playerId = 'PLAYER_ID';
    const playerIds = [playerId, 'PLAYER_ID_2'];

    test('starts with no associations for answer', () {
      final repository = AnswerPlayerAssociationRepository();
      expect(repository.getPlayersWhoHaveChosenAnswer(answerId), isEmpty);

      repository.close();
    });

    test('emits the updated result when a player is associated with answer',
        () {
      final repository = AnswerPlayerAssociationRepository();
      final stream = repository.getPlayersWhoHaveChosenAnswerStream(answerId);
      expectLater(stream, emits([playerId]));
      repository.addAssociation(playerId: playerId, answerId: answerId);

      expectLater(stream, emitsDone);
      repository.close();
    });

    test('returns answers when a player is associated', () {
      final repository = AnswerPlayerAssociationRepository();
      repository.addAssociation(answerId: answerId, playerId: playerId);
      expect(repository.getPlayersWhoHaveChosenAnswer(answerId), [playerId]);

      repository.close();
    });

    test('emits the updated result when a player is removed from answer', () {
      final repository = AnswerPlayerAssociationRepository();
      final stream = repository.getPlayersWhoHaveChosenAnswerStream(answerId);
      repository.addAssociation(playerId: playerId, answerId: answerId);

      expectLater(stream, emitsThrough([]));
      repository.removeAssociation(playerId: playerId, answerId: answerId);

      expectLater(stream, emitsDone);
      repository.close();
    });

    test('emits the updated result when all players are removed from answer',
        () {
      final repository = AnswerPlayerAssociationRepository();
      final stream = repository.getPlayersWhoHaveChosenAnswerStream(answerId);

      for (final playerId in playerIds) {
        repository.addAssociation(playerId: playerId, answerId: answerId);
      }

      expectLater(stream, emitsThrough([]));
      repository.removeAllByAnswer(answerId);

      expectLater(stream, emitsDone);
      repository.close();
    });

    test('emits the updated result when a player is toggled on for answer', () {
      final repository = AnswerPlayerAssociationRepository();
      final stream = repository.getPlayersWhoHaveChosenAnswerStream(answerId);

      expectLater(stream, emitsThrough([playerId]));
      repository.toggleAssociation(playerId: playerId, answerId: answerId);

      expectLater(stream, emitsDone);
      repository.close();
    });

    test('emits the updated result when a player is toggled off for answer',
        () {
      final repository = AnswerPlayerAssociationRepository();
      final stream = repository.getPlayersWhoHaveChosenAnswerStream(answerId);
      repository.addAssociation(playerId: playerId, answerId: answerId);

      expectLater(stream, emitsThrough([]));
      repository.toggleAssociation(playerId: playerId, answerId: answerId);

      expectLater(stream, emitsDone);
      repository.close();
    });
  });
}
