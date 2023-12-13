import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friendlyscorer/src/data/models.dart';
import 'package:macos_ui/macos_ui.dart';

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
      return MaterialPlayerPicker(
        players: players,
        selectedPlayerId: selectedPlayerId,
        onSelectPlayer: onSelectPlayer,
      );
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

    return MaterialPlayerPicker(
      players: players,
      selectedPlayerId: selectedPlayerId,
      onSelectPlayer: onSelectPlayer,
    );
  }
}

class MaterialPlayerPicker extends StatelessWidget {
  final List<Player> players;
  final String? selectedPlayerId;
  final void Function(String? playerId) onSelectPlayer;

  const MaterialPlayerPicker({
    super.key,
    this.players = const [],
    this.selectedPlayerId,
    required this.onSelectPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final selectedPlayerIdAlias = selectedPlayerId;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (players.isNotEmpty)
          Expanded(
            child: SegmentedButton<String>(
              emptySelectionAllowed: true,
              segments: players.map((p) {
                return ButtonSegment(
                  value: p.id,
                  label: Text(p.name),
                );
              }).toList(growable: false),
              selected: {
                if (selectedPlayerIdAlias != null) selectedPlayerIdAlias
              },
              onSelectionChanged: (selection) =>
                  onSelectPlayer(selection.singleOrNull),
            ),
          ),
        IconButton(
          onPressed:
              selectedPlayerId == null ? null : () => onSelectPlayer(null),
          icon: const Icon(Icons.cancel),
        ),
      ],
    );
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
        return Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            children: [
              MacosRadioButton(
                value: p.id,
                groupValue: selectedPlayerId,
                onChanged: onSelectPlayer,
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => onSelectPlayer(p.id),
                child: Text(p.name),
              ),
            ],
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
