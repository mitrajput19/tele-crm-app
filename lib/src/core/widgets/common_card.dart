import '../../app/app.dart';

class CommonCard extends StatelessWidget {
  final String? label;
  final bool hasLabel;
  final Widget? labelWidget;
  final TextStyle? labelStyle;
  final Color? labelBackgroundColor;
  final Widget? child;
  final bool hasBorder;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function()? onTap;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final bool hasBackground;
  final double? width;
  final double? height;

  const CommonCard({
    super.key,
    this.child,
    this.hasBorder = false,
    this.margin,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.hasBackground = true,
    this.onTap,
    this.width,
    this.height,
    this.hasLabel = false,
    this.label,
    this.labelWidget,
    this.labelStyle,
    this.labelBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = this.borderRadius ?? BorderRadius.circular(AppTheme.cardBorderRadius);

    return Container(
      width: width,
      height: height,
      child: Card(
        elevation: 0,
        color: hasBackground ? backgroundColor ?? Theme.of(context).cardColor : Colors.transparent,
        margin: margin ?? EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: hasBorder
              ? BorderSide(
                  color: AppColors.gray.withOpacity(.25),
                )
              : BorderSide.none,
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap == null
                ? null
                : () {
                    HapticHelper.trigger();
                    onTap?.call();
                  },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasLabel) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: labelBackgroundColor ?? AppColors.gray.withOpacity(.1),
                    ),
                    child: labelWidget ??
                        Text(
                          label ?? '-',
                          style: labelStyle ?? Theme.of(context).textTheme.tsMedium14,
                        ),
                  ),
                  CommonDivider(),
                ],
                Container(
                  padding: padding ?? EdgeInsets.all(12),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
