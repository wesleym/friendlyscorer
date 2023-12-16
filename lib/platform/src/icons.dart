import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Icon content suitable for each platform.
///
/// Because each icon is selected for its purpose in Friendly Scorer, the icon
/// selected for each platform may not otherwise have the same idiomatic usage
/// on the platform.
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

  /// Section header for the special rules that may apply to the submitted
  /// answers.
  static IconData get specialRules {
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoIcons.exclamationmark_square;
    } else {
      return Icons.assignment_late;
    }
  }

  /// Section header for the answers submitted in the round.
  static IconData get answers {
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoIcons.text_bubble;
    } else {
      return Icons.message;
    }
  }

  /// Section header for the players taking part in the round.
  static IconData get players {
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoIcons.person_3;
    } else {
      return Icons.groups;
    }
  }
}
