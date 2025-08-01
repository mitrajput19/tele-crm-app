import 'package:flutter/material.dart';

class KeyboardDismissible extends StatelessWidget {
  final Widget child;
  final bool dismissOnTap;

  const KeyboardDismissible({super.key, required this.child, this.dismissOnTap = true});

  void dismissKeyboard(BuildContext context) {
    if (dismissOnTap) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
