import '../../app/app.dart';

class CommonListTile extends StatelessWidget {
  final dynamic label;
  final bool hasLeadingIcon;
  final bool hasTrailingIcon;
  final dynamic icon;
  final EdgeInsets? margin;
  final EdgeInsets? contentPadding;
  final bool isDense;
  final Widget? trailing;
  final TextStyle? labelStyle;
  final bool hasBorder;
  final BorderRadius? borderRadius;
  final Function()? onTap;
  final bool isCustomLabel;

  const CommonListTile({
    super.key,
    this.label,
    this.hasLeadingIcon = true,
    this.hasTrailingIcon = true,
    this.icon,
    this.isDense = false,
    this.margin,
    this.contentPadding,
    this.trailing,
    this.hasBorder = false,
    this.borderRadius,
    this.labelStyle,
    this.isCustomLabel = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 16),
      child: ListTile(
        dense: isDense,
        tileColor: Theme.of(context).cardColor,
        shape: hasBorder
            ? RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.cardBorderRadius),
                side: BorderSide(
                  color: AppColors.gray.withOpacity(.25),
                ),
              )
            : RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.cardBorderRadius),
              ),
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
            ),
        leading: hasLeadingIcon
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonIcon(
                    icon ?? Icons.circle,
                    color: AppColors.gray,
                  )
                ],
              )
            : null,
        title: isCustomLabel
            ? label
            : Text(
                label ?? '-',
                style: labelStyle ?? Theme.of(context).textTheme.tsMedium14,
              ),
        trailing: hasTrailingIcon
            ? trailing ??
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.gray,
                )
            : null,
        onTap: onTap == null
            ? null
            : () {
                HapticHelper.trigger();
                onTap?.call();
              },
      ),
    );
  }
}
