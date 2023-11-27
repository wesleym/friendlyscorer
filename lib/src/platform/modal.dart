import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

void presentPlatformModal({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) {
  if (kIsWeb) {
    showBottomSheet(
      context: context,
      constraints: const BoxConstraints(maxWidth: 592),
      elevation: 8,
      builder: builder,
    );
    return;
  }

  if (Platform.isIOS) {
    showCupertinoDialog(context: context, builder: builder);
    return;
  }

  if (Platform.isMacOS) {
    showMacosSheet(context: context, builder: builder);
    return;
  }

  showBottomSheet(
    context: context,
    constraints: const BoxConstraints(maxWidth: 592),
    elevation: 8,
    builder: builder,
  );
}

Future<bool> presentPlatformDestructionConfirmation({
  required BuildContext context,
  Widget? title,
  Widget? message,
}) async {
  if (kIsWeb) {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title,
          content: message,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Keep'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  if (Platform.isIOS) {
    final result = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: title,
          message: message,
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Keep'),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(true),
              isDefaultAction: true,
              isDestructiveAction: true,
              child: const Text('Delete'),
            )
          ],
        );
      },
    );
    return result ?? false;
  }

  if (Platform.isMacOS) {
    final result = await showMacosAlertDialog<bool>(
      context: context,
      builder: (context) {
        return MacosAlertDialog(
          appIcon: const FlutterLogo(),
          title: title ?? const SizedBox(),
          message: message ?? const SizedBox(),
          primaryButton: PushButton(
            onPressed: () => Navigator.of(context).pop(true),
            controlSize: ControlSize.large,
            // Broken in https://github.com/macosui/macos_ui/issues/486.
            color: CupertinoColors.destructiveRed,
            child: const Text('Delete'),
          ),
          secondaryButton: PushButton(
            onPressed: () => Navigator.of(context).pop(false),
            controlSize: ControlSize.large,
            secondary: true,
            child: const Text('Keep'),
          ),
        );
      },
    );
    return result ?? false;
  }

  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: message,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
