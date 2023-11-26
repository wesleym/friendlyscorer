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
