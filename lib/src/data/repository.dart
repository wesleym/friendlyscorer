import 'dart:async';

import '../player/palette.dart';
import 'models.dart';

final _playerColorVendor = PlayerColorVendor();

class AnswerRepository {
  static AnswerRepository? _instance;
  static get instance => _instance ??= AnswerRepository();

  final _streamController = StreamController<List<Answer>>.broadcast();

  final _answers = [
    'Britney Spears',
    'Charles Barkley',
    'Chevy Chase',
    'Eddie Murphy',
    'Elon Musk',
    'Hugh Jackman',
    'Justin Timberlake',
    'Lin-Manuel Miranda',
    'Magnus Carlsen',
    'Paul Giamatti',
    'Paul Simon',
    'Robert Downey Jr.',
    'Ruth Gordon',
    'Steve Martin',
    'Taylor Lautner',
    'Taylor Swift',
    'Tina Fey',
    'Tom Hanks',
  ].map((s) => Answer(id: s, text: s)).toList();

  List<Answer> get answers => _answers;
  Stream<List<Answer>> get answerStream => _streamController.stream;
}

class PlayerRepository {
  static PlayerRepository? _instance;
  static get instance => _instance ??= PlayerRepository();

  final _streamController = StreamController<List<Player>>.broadcast();

  final _players = [
    'Brian',
    'Chip',
    'Kathy',
    'Lex',
    'Shelley',
    'CarlGPT',
  ]
      .map((n) => Player(id: n, name: n, color: _playerColorVendor.next()))
      .toList();
  List<Player> get players => _players;
  Stream<List<Player>> get playerStream => _streamController.stream;

  Player getPlayerById(String playerId) =>
      _players.singleWhere((p) => p.id == playerId);
}

class RuleRepository {
  final _rules = [];
}

class PlayerAnswerAssociation {
  final String playerId;
  final String answerId;

  PlayerAnswerAssociation({required this.playerId, required this.answerId});
}

class PlayerAnswerAssociationRepository {
  static PlayerAnswerAssociationRepository? _instance;
  static getInstance(PlayerRepository playerRepository) =>
      _instance ??= PlayerAnswerAssociationRepository(playerRepository);

  final _associations = [
    PlayerAnswerAssociation(playerId: 'Shelley', answerId: 'Britney Spears'),
  ];
  final _streamController =
      StreamController<List<PlayerAnswerAssociation>>.broadcast();
  final PlayerRepository _playerRepository;

  PlayerAnswerAssociationRepository(PlayerRepository playerRepository)
      : _playerRepository = playerRepository;

  List<Player> getPlayersWhoHaveChosenAnswer(String answerId) {
    return _associations
        .where((a) => a.answerId == answerId)
        .map((a) => _playerRepository.getPlayerById(a.playerId))
        .toList(growable: false);
  }

  Stream<List<Player>> getPlayersWhoHaveChosenAnswerStream(String answerId) {
    return _streamController.stream.map((asses) {
      return asses
          .where((a) => a.answerId == answerId)
          .map((a) => _playerRepository.getPlayerById(a.playerId))
          .toList(growable: false);
    });
  }
}
