import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:macos_ui/macos_ui.dart';

import '../data/models.dart';

class PlayerPicker extends StatelessWidget {
  final List<Player> players;
  final String? selectedPlayerId;
  final void Function(String? playerId) onSelectPlayer;

  const PlayerPicker({
    super.key,
    this.players = const [],
    this.selectedPlayerId,
    required this.onSelectPlayer,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const MaterialPlayerPicker();
    }

    if (Platform.isIOS) {
      return CupertinoPlayerPicker(
        players: players,
        selectedPlayerId: selectedPlayerId,
        onSelectPlayer: onSelectPlayer,
      );
    }

    if (Platform.isMacOS) {
      return MacPlayerPicker(
        players: players,
        selectedPlayerId: selectedPlayerId,
        onSelectPlayer: onSelectPlayer,
      );
    }

    return const MaterialPlayerPicker();
  }
}

class MaterialPlayerPicker extends StatelessWidget {
  const MaterialPlayerPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('<MaterialPlayerPicker>');
  }
}

class CupertinoPlayerPicker extends StatelessWidget {
  final List<Player> players;
  final String? selectedPlayerId;
  final void Function(String? playerId) onSelectPlayer;

  const CupertinoPlayerPicker({
    super.key,
    this.players = const [],
    this.selectedPlayerId,
    required this.onSelectPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (players.isNotEmpty)
          Expanded(
            child: CupertinoSlidingSegmentedControl(
              groupValue: selectedPlayerId,
              onValueChanged: onSelectPlayer,
              children: players.asMap().map(
                    (key, value) => MapEntry(
                      value.id,
                      Text(value.name),
                    ),
                  ),
            ),
          ),
        CupertinoButton(
          onPressed:
              selectedPlayerId == null ? null : () => onSelectPlayer(null),
          child: const Icon(CupertinoIcons.clear_circled),
        ),
      ],
    );
  }
}

class MacPlayerPicker extends StatelessWidget {
  final List<Player> players;
  final String? selectedPlayerId;
  final void Function(String? playerId) onSelectPlayer;

  const MacPlayerPicker({
    super.key,
    this.players = const [],
    this.selectedPlayerId,
    required this.onSelectPlayer,
  });

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) {
      return const PushButton(
        controlSize: ControlSize.regular,
        secondary: true,
        child: Text('Clear'),
      );
    }

    var playerRadios = players.map(
      (p) {
        return GestureDetector(
          onTap: () => onSelectPlayer(p.id),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Label(
              text: Text(p.name),
              icon: MacosRadioButton(
                value: p.id,
                groupValue: selectedPlayerId,
                onChanged: onSelectPlayer,
              ),
            ),
          ),
        );
      },
    ).toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...playerRadios,
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: PushButton(
            secondary: true,
            onPressed:
                selectedPlayerId == null ? null : () => onSelectPlayer(null),
            controlSize: ControlSize.small,
            child: const Text('Nobody'),
          ),
        ),
      ],
    );
  }
}
