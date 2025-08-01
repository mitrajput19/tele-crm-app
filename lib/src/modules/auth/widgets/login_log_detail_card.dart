import 'package:url_launcher/url_launcher.dart';

import '../../../app/app.dart';

class LoginLogDetailCard extends StatefulWidget {
  final LoginLogDetails loginLogDetails;

  const LoginLogDetailCard({
    Key? key,
    required this.loginLogDetails,
  }) : super(key: key);

  @override
  State<LoginLogDetailCard> createState() => _LoginLogDetailCardState();
}

class _LoginLogDetailCardState extends State<LoginLogDetailCard> {
  LoginLogDetails get loginLogDetails => widget.loginLogDetails;

  void openGoogleMapLink(BuildContext context, String link) async {
    try {
      final Uri url = Uri.parse(link);
      if (!await launchUrl(url)) {
        LogHelper.log('Could not launch $link');
        context.showSnackBar(ErrorMessages.couldNotOpenUrl);
      }
    } catch (e) {
      context.showSnackBar(ErrorMessages.couldNotOpenUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonLabelValueTile(
            hasBottomSpacing: true,
            label: AppTrKeys.browserDeviceDetails.tr(context),
            value: loginLogDetails.browserDeviceDetails != null && loginLogDetails.browserDeviceDetails!.isNotEmpty
                ? loginLogDetails.browserDeviceDetails
                : '-',
          ),
          Row(
            children: [
              CommonLabelValueTile(
                isExpanded: true,
                hasBottomSpacing: (loginLogDetails.locationUrl != null && loginLogDetails.locationUrl != ''),
                label: AppTrKeys.ipAddress.tr(context),
                value: loginLogDetails.ipAddress != null && loginLogDetails.ipAddress!.isNotEmpty
                    ? loginLogDetails.ipAddress
                    : '-',
              ),
              CommonLabelValueTile(
                isExpanded: true,
                hasBottomSpacing: (loginLogDetails.locationUrl != null && loginLogDetails.locationUrl != ''),
                label: AppTrKeys.dateTime.tr(context),
                value: loginLogDetails.createdAt,
              ),
            ],
          ),
          if (loginLogDetails.locationUrl != null && loginLogDetails.locationUrl != '')
            CommonListTile(
              onTap: () => openGoogleMapLink(context, loginLogDetails.locationUrl ?? ''),
              label: AppTrKeys.openGoogleMaps.tr(context),
              labelStyle: Theme.of(context).textTheme.tsMedium14.copyWith(
                    color: AppColors.secondary,
                  ),
              isDense: true,
              hasLeadingIcon: false,
              contentPadding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
            )
        ],
      ),
    );
  }
}
