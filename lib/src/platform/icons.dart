import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformIcons {
  PlatformIcons._();

  static IconData get trash {
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoIcons.trash;
    } else {
      return Icons.delete;
    }
  }

  static IconData get add {
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoIcons.add;
    } else {
      return Icons.add;
    }
  }

  static IconData get specialRules {
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoIcons.exclamationmark_square;
    } else {
      return Icons.assignment_late;
    }
  }

  static IconData get answers {
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoIcons.text_bubble;
    } else {
      return Icons.message;
    }
  }

  static IconData get players {
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoIcons.person_3;
    } else {
      return Icons.groups;
    }
  }
}
