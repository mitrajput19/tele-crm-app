import '../../app/app.dart';

class CommonAwesomeDialog {
  static Future show({
    required BuildContext context,
    required String title,
    required String description,
    DialogType? dialogType,
    String? confirmBtnText,
    String? cancelBtnText,
    Function()? onConfirmPressed,
    Function()? onCancelPressed,
  }) async {
    HapticHelper.trigger(HapticType.alertFocus);
    await AwesomeDialog(
      context: context,
      width: context.isTablet ? context.screenWidth / 2 : context.screenWidth,
      title: title,
      desc: description,
      btnOkText: confirmBtnText ?? AppTrKeys.confirm.tr(context),
      btnCancelText: cancelBtnText ?? AppTrKeys.cancel.tr(context),
      btnOkOnPress: onConfirmPressed,
      btnCancelOnPress: onCancelPressed ?? () {},
      isDense: true,
      bodyHeaderDistance: 0,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      dialogType: dialogType ?? DialogType.noHeader,
      btnOkColor: AppColors.success,
      btnCancelColor: AppColors.danger,
      dialogBackgroundColor: Theme.of(context).cardColor,
      titleTextStyle: Theme.of(context).textTheme.tsSemiBold18,
      descTextStyle: Theme.of(context).textTheme.tsRegular14,
      buttonsTextStyle: Theme.of(context).textTheme.tsLightMedium14,
      padding: EdgeInsets.symmetric(horizontal: 16),
      dialogBorderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      buttonsBorderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
    ).show();
  }
}
