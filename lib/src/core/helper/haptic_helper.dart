import 'package:flutter/services.dart';

enum HapticType {
  buttonTap,
  textFieldFocus,
  heavyAction,
  alertFocus,
  vibrate,
}

class HapticHelper {
  static void trigger([HapticType? type]) {
    switch (type ?? HapticType.buttonTap) {
      case HapticType.buttonTap:
        HapticFeedback.lightImpact();
        break;
      case HapticType.textFieldFocus:
        HapticFeedback.selectionClick();
        break;
      case HapticType.heavyAction:
        HapticFeedback.heavyImpact();
        break;
      case HapticType.alertFocus:
        HapticFeedback.mediumImpact();
        break;
      case HapticType.vibrate:
        HapticFeedback.vibrate();
        break;
    }
  }
}
