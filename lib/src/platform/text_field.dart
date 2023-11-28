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
      decoration: InputDecoration(
        hintText: placeholder,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
      onTapOutside: onTapOutside,
    );
  }
}

class PlatformInvisibleTextField extends StatelessWidget {
  final int? maxLines;
  final String? placeholder;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextStyle? style;
  final void Function(String)? _onSubmitted;
  final TextEditingController? _controller;

  /// [onTapOutside] is ignored on macOS.
  const PlatformInvisibleTextField({
    super.key,
    this.maxLines = 1,
    this.placeholder,
    this.onChanged,
    this.onTapOutside,
    this.style,
    void Function(String)? onSubmitted,
    TextEditingController? controller,
  })  : _onSubmitted = onSubmitted,
        _controller = controller;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return TextField(
        decoration: InputDecoration(hintText: placeholder),
        maxLines: maxLines,
        onChanged: onChanged,
        onTapOutside: onTapOutside,
        style: style,
        onSubmitted: _onSubmitted,
        controller: _controller,
      );
    }
    if (Platform.isIOS) {
      return CupertinoTextField(
        maxLines: maxLines,
        placeholder: placeholder,
        onChanged: onChanged,
        onTapOutside: onTapOutside,
        style: style,
        onSubmitted: _onSubmitted,
        controller: _controller,
        decoration: null,
      );
    }
    if (Platform.isMacOS) {
      return MacosTextField(
        maxLines: maxLines,
        placeholder: placeholder,
        onChanged: onChanged,
        style: style,
        onSubmitted: _onSubmitted,
        controller: _controller,
        decoration: null,
      );
    }

    return TextField(
      decoration: InputDecoration(hintText: placeholder),
      maxLines: maxLines,
      onChanged: onChanged,
      onTapOutside: onTapOutside,
      style: style,
      onSubmitted: _onSubmitted,
      controller: _controller,
    );
  }
}
