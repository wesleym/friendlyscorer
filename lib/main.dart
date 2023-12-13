import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:friendlyscorer/src/home/cupertino.dart';
import 'package:friendlyscorer/src/home/mac.dart';
import 'package:friendlyscorer/src/home/material.dart';

void main() async {
  if (kIsWeb) {
    runApp(const FriendlyMaterialApp());
    return;
  }

  if (Platform.isIOS) {
    runApp(const FriendlyCupertinoApp());
    return;
  }

  if (Platform.isMacOS) {
    await configureMacosWindowUtils();
    runApp(const FriendlyMacApp());
    return;
  }

  runApp(const FriendlyMaterialApp());
}
