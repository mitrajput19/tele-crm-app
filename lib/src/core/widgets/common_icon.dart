import 'package:flutter_svg/svg.dart';

import '../../app/app.dart';

class CommonIcon extends StatelessWidget {
  final dynamic icon;
  final Color? color;
  final double? size;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Border? border;
  final VoidCallback? onTap;
  final BoxShape shape;

  const CommonIcon(
    this.icon, {
    this.color,
    this.size,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.border,
    this.shape = BoxShape.circle,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(4),
        color: backgroundColor,
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            shape: shape,
            borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(4),
          ),
          child: InkWell(
            borderRadius: shape == BoxShape.circle ? BorderRadius.circular(50) : BorderRadius.circular(4),
            onTap: onTap == null
                ? null
                : () {
                    HapticHelper.trigger();
                    onTap?.call();
                  },
            child: Container(
              padding: padding ?? EdgeInsets.all(2),
              child: (icon is String)
                  ? icon.endsWith('.svg')
                      ? SvgPicture.asset(
                          icon,
                          height: size ?? 24,
                          width: size ?? 24,
                          colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
                        )
                      : icon == ''
                          ? Icon(Icons.error_outline_rounded, color: AppColors.gray)
                          : Image.asset(
                              icon,
                              height: size,
                              width: size,
                            )
                  : Icon(
                      icon,
                      color: color == null ? Theme.of(context).iconTheme.color : color,
                      size: size,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
