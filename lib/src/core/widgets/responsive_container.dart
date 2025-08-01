import '../../app/app.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final bool hasBorder;
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.hasBorder = true,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        decoration: hasBorder
            ? BoxDecoration(
                border: context.isTablet
                    ? Border(
                        left: BorderSide(
                          color: AppColors.gray.withOpacity(.25),
                        ),
                        right: BorderSide(
                          color: AppColors.gray.withOpacity(.25),
                        ),
                      )
                    : null,
              )
            : null,
        width: context.isTablet ? width / 2 : width,
        alignment: Alignment.topCenter,
        child: child,
      ),
    );
  }
}
