import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/home/editing.dart';
import 'package:friendlyscorer/src/platform/button.dart';
import 'package:friendlyscorer/src/platform/icon_button.dart';
import 'package:friendlyscorer/src/platform/icons.dart';
import 'package:friendlyscorer/src/platform/modal.dart';
import 'package:friendlyscorer/src/player/id.dart';
import 'package:friendlyscorer/src/player/models.dart';
import 'package:friendlyscorer/src/player/repository.dart';
import 'package:friendlyscorer/src/player/tiles.dart';

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
        child: const Text(
          'Clear',
          style: TextStyle(color: CupertinoColors.destructiveRed),
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
                  color: CupertinoColors.inactiveGray,
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
