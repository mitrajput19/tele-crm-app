
import '../../../app/app.dart';

abstract class AuthRepository {
  Future<User?> signIn(String email, String password);
  Future<User?> signUp(String email, String password, {Map<String, dynamic>? data});
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future empLogin(Map<String, dynamic> data);
  Future empLoginLog(Map<String, dynamic> data, String token);
  Future empLogout(Map<String, dynamic> data, String token);
  Future empResetPassword(Map<String, dynamic> data);
  Future empTwoFactorAuth(Map<String, dynamic> data);
  Future empChangeTwoFactorAuth(Map<String, dynamic> data);
  Future empAccountSettingsDetails(Map<String, dynamic> data);
  Future sendLocationData(Map<String, dynamic> data);
  Future getAppNotificationsList(Map<String, dynamic> data);
  Future getLoginLogsList(Map<String, dynamic> data);
  Future updateAlertReadStatus(Map<String, dynamic> data);
  Future<GenericResponse> getMasterCurrencyList(Map<String, dynamic> data);
  Future getCurrencyExchangeList(Map<String, dynamic> data);
  Future getDashboardData(Map<String, dynamic> data);
}
