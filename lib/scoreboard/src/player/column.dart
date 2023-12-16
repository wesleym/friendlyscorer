import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/scoreboard/src/home/editing.dart';
import 'package:friendlyscorer/platform/platform.dart';
import 'package:friendlyscorer/platform/src/icon.dart';
import 'package:friendlyscorer/scoreboard/src/player/id.dart';
import 'package:friendlyscorer/scoreboard/src/player/models.dart';
import 'package:friendlyscorer/scoreboard/src/player/repository.dart';
import 'package:friendlyscorer/scoreboard/src/player/tiles.dart';

class PlayerColumn extends StatelessWidget {
  final PlayerRepository _playerRepository;

  const PlayerColumn({
    super.key,
    required PlayerRepository playerRepository,
  }) : _playerRepository = playerRepository;

  @override
  Widget build(BuildContext context) {
    final editing = EditingProvider.of(context).editing;
    Widget? clearButton;
    if (editing) {
      clearButton = PlatformButton(
        onPressed: () => _onClearPlayers(context),
        child: Text(
          'Clear',
          style: TextStyle(color: PlatformColors.platformDanger),
        ),
      );
    }

    return StreamBuilder(
      initialData: _playerRepository.players,
      stream: _playerRepository.playerStream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlatformIcon(
                  PlatformIcons.players,
                  color: PlatformColors.sectionHeadingColor,
                ),
                if (clearButton != null) clearButton,
              ],
            ),
            const SizedBox(height: 8),
            ...snapshot.data!.map(
              (p) => Expanded(
                child: PlayerTile(player: p),
              ),
            ),
            if (!editing) NewPlayerTile(onCreatePlayer: _onCreatePlayer),
          ],
        );
      },
    );
  }

  void _onClearPlayers(BuildContext context) async {
    final delete = await presentPlatformDestructionConfirmation(
      context: context,
      title: const Text('Delete all players'),
    );
    if (delete) {
      _playerRepository.clear();
    }
  }

  void _onCreatePlayer(String name) {
    final id = PlayerIdVendor().next();
    _playerRepository.add(Player(
      id: id.toString(),
      name: name,
    ));
  }
}
