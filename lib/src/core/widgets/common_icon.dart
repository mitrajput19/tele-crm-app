import '../../app/app.dart';

class CommonIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Function()? onTap;
  final BorderRadius? borderRadius;

  const CommonIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Icon(
      icon,
      size: size ?? 24,
      color: color ?? Theme.of(context).iconTheme.color,
    );

    if (backgroundColor != null) {
      iconWidget = Container(
        padding: padding ?? EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: iconWidget,
      );
    }

    if (onTap != null) {
      iconWidget = InkWell(
        onTap: () {
          HapticHelper.trigger();
          onTap?.call();
        },
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        child: iconWidget,
      );
    }

    return Container(
      margin: margin,
      child: iconWidget,
    );
  }
}