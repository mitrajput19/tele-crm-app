import '../../app/app.dart';

class CommonFilledButton extends StatelessWidget {
  final String? label;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool isLoading;
  final Function()? onPressed;
  final EdgeInsets? margin;
  final double height;
  final Widget? icon;
  final bool isHalfWidth;

  const CommonFilledButton({
    Key? key,
    this.label,
    this.backgroundColor,
    this.labelColor,
    this.isLoading = false,
    this.onPressed,
    this.margin,
    this.height = 46,
    this.icon,
    this.isHalfWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: isHalfWidth ? context.screenWidth / 2 : null,
      child: ElevatedButton(
        child: isLoading
            ? Container(
                height: 26,
                child: FittedBox(
                  child: CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                    color: AppColors.light,
                  ),
                ),
              )
            : FittedBox(
                child: Row(
                  children: [
                    icon ?? SizedBox(),
                    Text(
                      label ?? AppStrings.label,
                      style: Theme.of(context)
                          .textTheme
                          .tsRegular14
                          .copyWith(fontSize: height <= 32 ? 12 : 14, color: labelColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: Size(double.infinity, height),
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
        ),
        onPressed: onPressed == null
            ? null
            : () {
                HapticHelper.trigger();
                onPressed?.call();
              },
      ),
    );
  }
}
