import 'dart:async';

import 'package:friendlyscorer/defaults.dart';
import 'package:friendlyscorer/scoreboard/src/player/models.dart';

class PlayerRepository {
  static PlayerRepository? _instance;

  PlayerRepository._();
  factory PlayerRepository() => _instance ??= PlayerRepository._();

  final _streamController = StreamController<List<Player>>.broadcast();

  final _players = defaultPlayers.toList();
  List<Player> get players => _players;
  Stream<List<Player>> get playerStream => _streamController.stream;

  Player? getPlayerById(String playerId) =>
      _players.where((p) => p.id == playerId).singleOrNull;

  void clear() {
    _players.clear();
    _streamController.add(_players);
  }

  void add(Player player) {
    _players.add(player);
    _streamController.add(_players);
  }
}
