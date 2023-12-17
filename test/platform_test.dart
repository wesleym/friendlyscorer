import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:friendlyscorer/platform.dart';

void main() {
  for (final textDirection in TextDirection.values) {
    testWidgets('PlatformButton renders consistently on iOS in $textDirection',
        (tester) async {
      // Create the widget by telling the tester to build it.
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: PlatformProvider(
            platformOverride: FriendlyPlatform.iOS,
            child: const PlatformButton(
              child: Text('Platform Button'),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(PlatformButton),
        matchesGoldenFile('platformButton-iOS-${textDirection.name}.png'),
      );
    });

    // Widget testing hasn't been set up for macOS. macOS widgets need a
    // MacosTheme, and setting one of these up appears to call
    // getColorComponents in package appkit_ui_element_colors, which tries to do
    // stuff across a channel.

    testWidgets(
        'PlatformButton renders consistently on Material platforms in $textDirection',
        (tester) async {
      // Create the widget by telling the tester to build it.
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: PlatformProvider(
            platformOverride: FriendlyPlatform.other,
            child: const PlatformButton(
              child: Text('Platform Button'),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(PlatformButton),
        matchesGoldenFile('platformButton-material-${textDirection.name}.png'),
      );
    });
  }
}
