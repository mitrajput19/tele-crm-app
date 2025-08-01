import '../../app/app.dart';

class CommonOutlinedButton extends StatelessWidget {
  final String? label;
  final bool isLoading;
  final Function()? onPressed;
  final EdgeInsets? margin;
  final double? width;
  final double height;

  const CommonOutlinedButton({
    super.key,
    this.label,
    this.isLoading = false,
    this.onPressed,
    this.margin,
    this.width,
    this.height = 46,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: OutlinedButton(
        child: isLoading
            ? Container(
                height: 26,
                child: FittedBox(
                  child: CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              )
            : FittedBox(
                child: Text(
                  label ?? AppStrings.label,
                  style: Theme.of(context).textTheme.tsRegular14.copyWith(
                        fontSize: height <= 32 ? 10 : 14,
                        color: Theme.of(context).iconTheme.color!,
                      ),
                ),
              ),
        style: OutlinedButton.styleFrom(
          elevation: 0,
          minimumSize: Size(double.infinity, height),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
        ).copyWith(
          side: WidgetStateProperty.resolveWith<BorderSide>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) ;
              return BorderSide(
                color: Theme.of(context).iconTheme.color!,
              );
            },
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
