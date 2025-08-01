import '../../app/app.dart';

class BottomSheetHelper {
  BottomSheetHelper._privateConstructor();

  static Completer<void>? _bottomSheetCompleter;

  static bool get isBottomSheetOpen => _bottomSheetCompleter?.isCompleted == false;

  static void closeBottomSheet() {
    if (_bottomSheetCompleter?.isCompleted == false) {
      _bottomSheetCompleter?.complete();
    }
  }

  static Future showCommonBottomSheet(
    BuildContext context, {
    Widget? child,
    Function? onClose,
  }) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    _bottomSheetCompleter = Completer<void>();

    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppTheme.cardBorderRadius),
          topRight: Radius.circular(AppTheme.cardBorderRadius),
        ),
      ),
      routeSettings: const RouteSettings(name: 'bottom_sheet'),
      builder: (context) => PopScope(
        child: SafeArea(child: child ?? Container()),
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) closeBottomSheet();
        },
      ),
    ).then((value) {
      _bottomSheetCompleter = null;
      if (onClose != null) onClose();
      return value;
    });
  }
}
