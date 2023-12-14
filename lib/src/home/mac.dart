import 'package:flutter/cupertino.dart';
import 'package:friendlyscorer/src/editing/editing.dart';
import 'package:friendlyscorer/src/home/home_page.dart';
import 'package:macos_ui/macos_ui.dart';

class FriendlyMacApp extends StatelessWidget {
  const FriendlyMacApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      home: const MacHomePage(),
    );
  }
}

class MacHomePage extends StatefulWidget {
  const MacHomePage({super.key});

  @override
  State<MacHomePage> createState() => _MacHomePageState();
}

class _MacHomePageState extends State<MacHomePage> {
  var _editing = false;

  @override
  Widget build(BuildContext context) {
    final brightness = MacosTheme.of(context).brightness;
    final Color contentAreaColor;
    switch (brightness) {
      case Brightness.light:
        contentAreaColor = MacosColors.black;
      case Brightness.dark:
        contentAreaColor = MacosColors.white;
      default:
        throw StateError('Unexpected brightness $brightness');
    }

    return MacosWindow(
      child: Builder(builder: (context) {
        return EditingProvider(
          editing: _editing,
          child: MacosScaffold(
            toolBar: ToolBar(
              title: const Text('Friendly Scorer'),
              actions: [
                ToolBarIconButton(
                  label: 'Edit',
                  tooltipMessage: 'Edit',
                  icon: const MacosIcon(CupertinoIcons.pencil),
                  showLabel: false,
                  onPressed: () {
                    setState(() => _editing = !_editing);
                  },
                ),
              ],
            ),
            children: [
              ContentArea(
                builder: (context, scrollController) {
                  return DecoratedBox(
                    decoration: BoxDecoration(color: contentAreaColor),
                    child: const HomePageBody(),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

/// This method initializes macos_window_utils and styles the window.
Future<void> configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig(
    toolbarStyle: NSWindowToolbarStyle.unified,
  );
  await config.apply();
}
