import 'package:flutter/cupertino.dart';

class EditingProvider extends InheritedWidget {
  final bool editing;

  const EditingProvider({
    super.key,
    required super.child,
    required this.editing,
  });

  static EditingProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EditingProvider>();
  }

  static EditingProvider of(BuildContext context) {
    final EditingProvider? result = maybeOf(context);
    assert(result != null, 'No EditingProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(EditingProvider oldWidget) =>
      oldWidget.editing != editing;
}
