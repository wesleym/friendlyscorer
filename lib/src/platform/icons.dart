import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformIcons {
  PlatformIcons._();

  static IconData get add {
    if (kIsWeb) {
      return Icons.add;
    }

    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoIcons.add;
    }

    return Icons.add;
  }

  static IconData get specialRules {
    if (kIsWeb) {
      return Icons.assignment_late;
    }

    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoIcons.exclamationmark_square;
    }

    return Icons.assignment_late;
  }

  static IconData get answers {
    if (kIsWeb) {
      return Icons.message;
    }

    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoIcons.text_bubble;
    }

    return Icons.message;
  }

  static IconData get players {
    if (kIsWeb) {
      return Icons.groups;
    }

    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoIcons.person_3;
    }

    return Icons.groups;
  }

  static IconData get chevronDown {
    if (kIsWeb) {
      return Icons.expand_more;
    }

    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoIcons.chevron_down;
    }

    return Icons.expand_more;
  }

  static IconData get chevronUp {
    if (kIsWeb) {
      return Icons.expand_less;
    }

    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoIcons.chevron_up;
    }

    return Icons.expand_less;
  }
}
