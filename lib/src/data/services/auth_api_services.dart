import '../../app/app.dart';

class AuthApiServices {
  final NetworkServices services;
  AuthApiServices({required this.services});

  Future empLogin(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.empLogin,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future empLoginLog(Map<String, dynamic> data, String token) async {
    var response = await services.post(
      path: AppUrls.empLoginLog,
      data: data,
      token: token,
    );
    return GenericResponse.fromJson(response);
  }

  Future empLogout(Map<String, dynamic> data, String token) async {
    var response = await services.post(
      path: AppUrls.empLogout,
      data: data,
      token: token,
    );
    return GenericResponse.fromJson(response);
  }

  Future empForgotPassword(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.empForgotPassword,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future empResetPassword(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.empResetPassword,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future empChangePassword(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.empChangePassword,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future empTwoFactorAuth(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.empTwoFactorAuth,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future empChangeTwoFactorAuth(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.empChangeTwoFactorAuth,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future empAccountSettingsDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeAccountSettingsDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future sendLocationData(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.sendLocationData,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getAppNotificationsList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getAppNotificationsList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getLoginLogsList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.empLoginActivityList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future updateAlertReadStatus(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.updateAlertReadStatus,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getMasterCurrencyList(Map<String, dynamic> data) async {
    var masterBaseUrl = '';
    var apiUrl = await '$masterBaseUrl${AppUrls.getCountryCurrencyList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getCurrencyExchangeList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getCurrencyExchangeList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getDashboardData(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getDashboardData,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }
}
