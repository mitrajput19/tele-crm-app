import '../../app/app.dart';

class CommonBottomSheet extends StatefulWidget {
  final bool? hasSearch;
  final String? label;
  final bool useMaxHeight;
  final List<Widget>? children;
  final bool showHeader;
  final bool hasBottomSpacing;
  final EdgeInsets? padding;

  const CommonBottomSheet({
    super.key,
    this.hasSearch,
    this.label,
    this.showHeader = true,
    this.hasBottomSpacing = true,
    this.useMaxHeight = false,
    this.children,
    this.padding,
  });

  @override
  State<CommonBottomSheet> createState() => _CommonBottomSheetState();
}

class _CommonBottomSheetState extends State<CommonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: widget.useMaxHeight ? context.screenHeight - MediaQuery.of(context).padding.top : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showHeader)
              Container(
                decoration: BoxDecoration(
                  color: context.isDarkMode ? AppColors.darkCardBackground : AppColors.lightCardBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppTheme.cardBorderRadius),
                    topRight: Radius.circular(AppTheme.cardBorderRadius),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Container(
                      height: 6,
                      width: 120,
                      decoration: BoxDecoration(
                        color: context.isDarkMode ? AppColors.light.withOpacity(.25) : AppColors.gray.withOpacity(.25),
                        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        widget.label ?? AppStrings.label,
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                      trailing: IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        splashRadius: 24,
                        icon: Icon(
                          Icons.close,
                          color: context.isDarkMode ? AppColors.light : AppColors.gray,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
            CommonDivider(),
            if (widget.hasSearch ?? false) SizedBox(height: 16),
            if (widget.hasSearch ?? false)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CommonTextField(
                  hasLabel: false,
                  hintText: 'Search',
                ),
              ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: widget.padding ?? EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.children ?? [],
                  ),
                  if (widget.hasBottomSpacing) SizedBox(height: 56),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
