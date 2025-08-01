import '../../app/app.dart';

class CommonChip extends StatelessWidget {
  final String? label;
  final Color? backgroundColor;
  final Color? labelColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextStyle? labelStyle;

  const CommonChip({
    super.key,
    this.label,
    this.backgroundColor,
    this.labelColor,
    this.padding,
    this.margin,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return label == null
        ? Text(
            label ?? '',
            style: Theme.of(context).textTheme.tsMedium10.copyWith(
                  color: labelColor ?? Theme.of(context).textTheme.bodyLarge?.color,
                ),
          )
        : Container(
            margin: margin ?? EdgeInsets.zero,
            padding: padding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: backgroundColor ?? AppColors.gray.withOpacity(.25),
            ),
            child: Text(
              label ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: labelStyle ??
                  Theme.of(context).textTheme.tsMedium10.copyWith(
                        color: labelColor ?? Theme.of(context).textTheme.bodyLarge?.color,
                      ),
            ),
          );
  }
}
