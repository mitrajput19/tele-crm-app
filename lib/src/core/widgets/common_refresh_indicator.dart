import '../../app/app.dart';

class CommonRefreshIndicator extends StatelessWidget {
  final Widget child;
  final RefreshCallback onRefresh;

  const CommonRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      color: AppColors.white,
      backgroundColor: AppColors.secondary,
      onRefresh: onRefresh,
    );
  }
}
