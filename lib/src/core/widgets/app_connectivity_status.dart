import '../../app/app.dart';

class AppConnectivityStatus extends StatelessWidget {
  final bool isConnected;
  const AppConnectivityStatus({super.key, this.isConnected = true});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isConnected,
      child: Material(
        color: AppColors.danger,
        child: SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonIcon(
                  Icons.info_outline_rounded,
                  color: AppColors.light,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  ErrorMessages.noInternetConnection,
                  style: Theme.of(context).textTheme.tsLightRegular14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
