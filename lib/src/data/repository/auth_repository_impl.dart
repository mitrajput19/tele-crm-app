import '../../app/app.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiServices apis;
  final SupabaseService supabaseService;
  
  AuthRepositoryImpl({
    required this.apis,
    required this.supabaseService,
  });

  @override
  Future<User?> signIn(String email, String password) async {
    try {
      return await supabaseService.signIn(email, password);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<User?> signUp(String email, String password, {Map<String, dynamic>? data}) async {
    try {
      return await supabaseService.signUp(email, password, data: data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return await supabaseService.signOut();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      return await supabaseService.resetPassword(email);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future empLogin(Map<String, dynamic> data) {
    try {
      return apis.empLogin(data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future empLoginLog(Map<String, dynamic> data, String token) {
    try {
      return apis.empLoginLog(data, token);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future empLogout(Map<String, dynamic> data, String token) {
    try {
      return apis.empLogout(data, token);
    } catch (e) {
      throw e;
    }
  }

  

  @override
  Future empResetPassword(Map<String, dynamic> data) async {
    try {
      return await apis.empResetPassword(data);
    } catch (e) {
      throw e;
    }
  }

  

  @override
  Future empTwoFactorAuth(Map<String, dynamic> data) async {
    try {
      return apis.empTwoFactorAuth(data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future empChangeTwoFactorAuth(Map<String, dynamic> data) async {
    try {
      return apis.empChangeTwoFactorAuth(data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future empAccountSettingsDetails(Map<String, dynamic> data) async {
    try {
      return apis.empAccountSettingsDetails(data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future sendLocationData(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.sendLocationData(data);
      if (response.success == 1) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getAppNotificationsList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.getAppNotificationsList(data);
      if (response.success == 1) {
        var responseData = AppNotificationDetails.listFromJson(response.data);
        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getLoginLogsList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.getLoginLogsList(data);

      if (response.success == 1) {
        var responseData = LoginLogDetails.listFromJson(response.data);
        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future updateAlertReadStatus(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.updateAlertReadStatus(data);

      if (response.success == 1) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<GenericResponse> getMasterCurrencyList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.getMasterCurrencyList(data);
      if (response.success == 1) {
        var responseData = CurrencyMasterDetails.listFromJson(response.data);

        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getCurrencyExchangeList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.getCurrencyExchangeList(data);
      if (response.success == 1) {
        var responseData = CurrencyExchangeDetails.listFromJson(response.data);

        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getDashboardData(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.getDashboardData(data);

      if (response.success == 1) {
        var responseData = DashboardKpiWidgetData.listFromJson(response.data);
        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }
}
