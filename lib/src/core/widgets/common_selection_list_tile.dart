import '../../app/app.dart';

class CommonSelectionListTile extends StatelessWidget {
  final String? label;
  final bool hasLeadingIcon;
  final IconData? icons;
  final EdgeInsets? padding;
  final bool isDense;
  final Widget? trailing;
  final Function()? onTap;
  final bool isSelected;
  final TextStyle? valueTextStyle;

  const CommonSelectionListTile({
    super.key,
    this.label,
    this.hasLeadingIcon = true,
    this.icons,
    this.isDense = false,
    this.padding,
    this.trailing,
    this.onTap,
    this.valueTextStyle,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding ?? EdgeInsets.only(bottom: 16),
      child: ListTile(
        dense: isDense,
        tileColor: Theme.of(context).scaffoldBackgroundColor,
        shape: Border(
          bottom: BorderSide(
            color: AppColors.gray.withOpacity(.25),
          ),
        ),
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        leading: hasLeadingIcon
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icons ?? Icons.circle,
                    color: AppColors.secondary,
                  )
                ],
              )
            : null,
        title: Text(
          label ?? '',
          style: valueTextStyle ?? Theme.of(context).textTheme.tsRegular14,
        ),
        trailing: Visibility(
          visible: isSelected,
          child: Icon(
            Icons.check_circle_rounded,
            color: AppColors.secondary,
            size: 20,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
