import '../../app/app.dart';

extension SnackBarExtension on BuildContext {
  void showSnackBar(
    String? message, {
    Color? backgroundColor,
    SnackbarType? type = SnackbarType.standard,
  }) {
    if (message == null || message == '' || message.isEmpty) return;
    backgroundColor ??= getSnackbarColor(type);
    ScaffoldMessenger.of(this).clearSnackBars();
    HapticHelper.trigger(HapticType.alertFocus);
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        elevation: 0,
        width: this.isTablet ? this.screenWidth / 2 : null,
        showCloseIcon: true,
        margin: this.isTablet ? null : EdgeInsets.all(16),
        duration: Duration(seconds: 3),
        closeIconColor: AppColors.light,
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        content: Text(message),
      ),
    );
  }
}

void showSnackbarBloc(String? message, [SnackbarType? type]) {
  getIt.get<SnackbarBloc>().add(ShowSnackbarEvent(message, type));
}

Color getSnackbarColor(SnackbarType? type) {
  Color color = AppColors.lightPrimary;

  switch (type) {
    case SnackbarType.success:
      color = AppColors.success;
      break;
    case SnackbarType.info:
      color = AppColors.info;
      break;
    case SnackbarType.danger:
      color = AppColors.danger;
      break;
    case SnackbarType.warning:
      color = AppColors.warning;
      break;
    default:
  }

  return color;
}

enum SnackbarType {
  standard,
  success,
  info,
  warning,
  danger,
}
