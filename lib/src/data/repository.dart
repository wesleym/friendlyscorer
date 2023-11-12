import 'dart:async';

import 'package:friendlyscorer/src/rule_vendor.dart';

import '../player/palette.dart';
import 'models.dart';

final _playerColorVendor = PlayerColorVendor();
final _ruleIdVendor = RuleIdVendor();

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
  static RuleRepository? _instance;
  static get instance => _instance ??= RuleRepository();

  final _streamController = StreamController<List<Rule>>.broadcast();

  final _rules = [
    'Buck Henry',
    'Alec Baldwin or Steve Martin',
    'Athlete',
  ].map((r) => Rule(id: _ruleIdVendor.next(), text: r)).toList();
  List<Rule> get rules => _rules;
  Stream<List<Rule>> get ruleStream => _streamController.stream;

  Rule getRuleById(String ruleId) => _rules.singleWhere((r) => r.id == ruleId);
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

  void addAssociation({
    required String playerId,
    required String answerId,
  }) {
    _associations.add(PlayerAnswerAssociation(
      playerId: playerId,
      answerId: answerId,
    ));
    _streamController.add(_associations);
  }

  void removeAssociation({
    required String playerId,
    required String answerId,
  }) {
    _associations
        .removeWhere((a) => a.playerId == playerId && a.answerId == answerId);
    _streamController.add(_associations);
  }

  void toggleAssociation({
    required String playerId,
    required String answerId,
  }) {
    if (_associations
        .any((a) => a.playerId == playerId && a.answerId == answerId)) {
      removeAssociation(playerId: playerId, answerId: answerId);
    } else {
      addAssociation(playerId: playerId, answerId: answerId);
    }
  }
}

class AnswerRuleAssociation {
  final String ruleId;
  final String answerId;

  AnswerRuleAssociation({required this.ruleId, required this.answerId});
}

class AnswerRuleAssociationRepository {
  static AnswerRuleAssociationRepository? _instance;
  static getInstance(RuleRepository ruleRepository) =>
      _instance ??= AnswerRuleAssociationRepository(ruleRepository);

  final _associations = [
    AnswerRuleAssociation(ruleId: 'A', answerId: 'Britney Spears'),
  ];
  final _streamController =
      StreamController<List<AnswerRuleAssociation>>.broadcast();
  final RuleRepository _ruleRepository;

  AnswerRuleAssociationRepository(RuleRepository ruleRepository)
      : _ruleRepository = ruleRepository;

  List<Rule> getRulesAffectingAnswer(String answerId) {
    return _associations
        .where((a) => a.answerId == answerId)
        .map((a) => _ruleRepository.getRuleById(a.ruleId))
        .toList(growable: false);
  }

  Stream<List<Rule>> getStreamOfRulesAffectingAnswer(String answerId) {
    return _streamController.stream.map((asses) {
      return asses
          .where((a) => a.answerId == answerId)
          .map((a) => _ruleRepository.getRuleById(a.ruleId))
          .toList(growable: false);
    });
  }

  void addAssociation({
    required String ruleId,
    required String answerId,
  }) {
    _associations.add(AnswerRuleAssociation(
      ruleId: ruleId,
      answerId: answerId,
    ));
    _streamController.add(_associations);
  }

  void removeAssociation({
    required String ruleId,
    required String answerId,
  }) {
    _associations
        .removeWhere((a) => a.ruleId == ruleId && a.answerId == answerId);
    _streamController.add(_associations);
  }

  void toggleAssociation({
    required String ruleId,
    required String answerId,
  }) {
    if (_associations
        .any((a) => a.ruleId == ruleId && a.answerId == answerId)) {
      removeAssociation(ruleId: ruleId, answerId: answerId);
    } else {
      addAssociation(ruleId: ruleId, answerId: answerId);
    }
  }
}
