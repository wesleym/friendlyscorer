import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'data/repository.dart';

class InputSheet extends StatefulWidget {
  final DraggableScrollableController _draggableScrollableController;
  final ScrollController _scrollController;

  const InputSheet({
    super.key,
    required DraggableScrollableController draggableScrollableController,
    required ScrollController scrollController,
  })  : _draggableScrollableController = draggableScrollableController,
        _scrollController = scrollController;

  @override
  State<InputSheet> createState() => _InputSheetState();
}

class _InputSheetState extends State<InputSheet> {
  late final PlayerRepository _playerRepository;

  @override
  void initState() {
    super.initState();

    _playerRepository = PlayerRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: SingleChildScrollView(
        controller: widget._scrollController,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const Text('◖■◗'),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CupertinoButton(
                        onPressed: () {
                          if (widget._draggableScrollableController.size <=
                              0.1) {
                            unawaited(
                                widget._draggableScrollableController.animateTo(
                              1,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                            ));
                          } else {
                            unawaited(
                                widget._draggableScrollableController.animateTo(
                              0.1,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                            ));
                          }
                        },
                        child: !widget._draggableScrollableController
                                    .isAttached ||
                                widget._draggableScrollableController.size <=
                                    0.2
                            ? const Icon(CupertinoIcons.chevron_up)
                            : const Icon(CupertinoIcons.chevron_down)),
                  ),
                ],
              ),
              const CupertinoTextField(
                  maxLines: 6,
                  placeholder:
                      'Britney Spears, Charles Barkley, Chevy Chase, Eddie Murphy'),
              const SizedBox(height: 8),
              StreamBuilder(
                initialData: _playerRepository.players,
                stream: _playerRepository.playerStream,
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoSlidingSegmentedControl(
                        groupValue: null,
                        onValueChanged: (value) {},
                        children: snapshot.data!.asMap().map(
                              (key, value) => MapEntry(
                                value.id,
                                Text(value.name),
                              ),
                            ),
                      ),
                      CupertinoButton(
                        onPressed: () {},
                        child: const Text('Nobody'),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              CupertinoButton.filled(
                  child: const Text('Add answers'), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
