import '../../app/app.dart';

class CommonButton extends StatelessWidget {
  final String? label;
  final Widget? child;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool isLoading;

  const CommonButton({
    super.key,
    this.label,
    this.child,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.borderRadius,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 48,
      margin: margin,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.lightPrimary,
          foregroundColor: textColor ?? AppColors.light,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor ?? AppColors.light),
                ),
              )
            : child ??
                Text(
                  label ?? 'Button',
                  style: Theme.of(context).textTheme.tsMedium14.copyWith(
                    color: textColor ?? AppColors.light,
                  ),
                ),
      ),
    );
  }
}