import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class PlatformTextField extends StatelessWidget {
  final int? maxLines;
  final String? placeholder;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;

  /// [onTapOutside] is ignored on macOS.
  const PlatformTextField({
    super.key,
    this.maxLines,
    this.placeholder,
    this.onChanged,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: placeholder,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
        onTapOutside: onTapOutside,
      );
    }

    if (Platform.isIOS) {
      return CupertinoTextField(
        maxLines: maxLines,
        placeholder: placeholder,
        onChanged: onChanged,
        onTapOutside: onTapOutside,
      );
    }
    if (Platform.isMacOS) {
      return MacosTextField(
        maxLines: maxLines,
        placeholder: placeholder,
        onChanged: onChanged,
      );
    }

    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(hintText: placeholder),
      onChanged: onChanged,
      onTapOutside: onTapOutside,
    );
  }
}
