import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('👯'),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                const Text('aaa'),
                const Text('aaa'),
                const Text('aaa'),
                const Text('aaa'),
                const Spacer(),
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.add),
                ),
              ],
            ),
            const Column(
              children: [
                Text('aaa'),
                Text('aaa'),
                Text('aaa'),
                Text('aaa'),
              ],
            ),
            Column(
              children: [
                const Text('aaa'),
                const Text('aaa'),
                const Text('aaa'),
                const Text('aaa'),
                const Spacer(),
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
