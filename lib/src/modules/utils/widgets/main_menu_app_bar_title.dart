import '../../../app/app.dart';

class MainMenuAppBarTitle extends StatelessWidget {
  final String title;
  final bool fromHome;
  const MainMenuAppBarTitle({
    super.key,
    required this.title,
    this.fromHome = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text(title.tr(context))),
            if (fromHome) ...[
              SizedBox(width: 8),
              Icon(Icons.arrow_drop_down_rounded),
            ]
          ],
        ),
      ),
      onTap: !fromHome
          ? null
          : () {
              // BottomSheetHelper.showCommonBottomSheet(
              //   context,
              //   child: CommonBottomSheet(
              //     label: AppTrKeys.mainMenu.tr(context),
              //     useMaxHeight: true,
              //     padding: EdgeInsets.all(16),
              //     children: [
                
              //     ],
              //   ),
              // );
            },
    );
  }
}
