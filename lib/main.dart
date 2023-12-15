import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/home/cupertino.dart';
import 'package:friendlyscorer/home/mac.dart';
import 'package:friendlyscorer/home/material.dart';

void main() async {
  if (!kIsWeb && Platform.isIOS) {
    runApp(const FriendlyCupertinoApp());
  } else if (!kIsWeb && Platform.isMacOS) {
    await configureMacosWindowUtils();
    runApp(const FriendlyMacApp());
  } else {
    runApp(const FriendlyMaterialApp());
  }
}
