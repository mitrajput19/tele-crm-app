import '../../app/app.dart';

class CommonTabBar extends StatefulWidget {
  final bool isScrollable;
  final List<String> tabsTitle;
  final Widget? middleChild;
  final List<Widget>? tabs;
  final bool hasBackground;
  final Function(int index)? onTabChanged;
  const CommonTabBar({
    super.key,
    this.isScrollable = false,
    required this.tabsTitle,
    this.middleChild,
    this.tabs,
    this.hasBackground = true,
    this.onTabChanged,
  });

  @override
  State<CommonTabBar> createState() => _CommonTabBarState();
}

class _CommonTabBarState extends State<CommonTabBar> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: widget.tabsTitle.length,
      vsync: this,
    );

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        widget.onTabChanged?.call(tabController.index);
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(AppTheme.tabbarBorderRadius);
    return Scaffold(
      body: Column(
        children: [
          Gap(8),
          Container(
            height: 56,
            width: double.infinity,
            padding: EdgeInsets.all(8).copyWith(top: 0, left: 16, right: 16),
            color: widget.hasBackground ? Theme.of(context).appBarTheme.backgroundColor : null,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: widget.hasBackground
                    ? context.isDarkMode
                        ? AppColors.gray.shade900
                        : AppColors.gray.withOpacity(.25)
                    : null,
              ),
              child: TabBar(
                controller: tabController,
                isScrollable: widget.isScrollable,
                tabAlignment: widget.isScrollable ? TabAlignment.center : TabAlignment.fill,
                splashBorderRadius: borderRadius,
                indicator: BoxDecoration(
                  borderRadius: borderRadius,
                  color: widget.hasBackground ? AppColors.light : null,
                ),
                labelPadding: EdgeInsets.symmetric(horizontal: 4),
                labelStyle: widget.hasBackground
                    ? Theme.of(context).textTheme.tsMedium14
                    : Theme.of(context).textTheme.tsSemiBold14.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          decorationColor: AppColors.dark,
                        ),
                unselectedLabelStyle: Theme.of(context).textTheme.tsMedium14.copyWith(
                      color: context.isDarkMode ? AppColors.light : AppColors.dark,
                    ),
                tabs: widget.tabsTitle
                    .map((label) =>
                        Container(margin: EdgeInsets.symmetric(horizontal: 16), child: Tab(text: label.tr(context))))
                    .toList(),
              ),
            ),
          ),
          if (widget.middleChild != null) widget.middleChild!,
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: widget.tabs == null
                  ? widget.tabsTitle.map((label) => Center(child: Text(label.tr(context)))).toList()
                  : widget.tabs!.map((child) => child).toList(),
            ),
          ),
        ],
      ),
    );
  }
}