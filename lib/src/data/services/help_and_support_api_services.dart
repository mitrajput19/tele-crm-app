import '../../app/app.dart';

class HelpAndSupportApiServices {
  final NetworkServices services;
  HelpAndSupportApiServices({required this.services});

  Future getFaqsList(Map<String, dynamic> data) async {
    var adminBaseUrl = '';
    var apiUrl = await '$adminBaseUrl${AppUrls.getFaqsList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future getAccounManagerList(Map<String, dynamic> data) async {
    var adminBaseUrl = '';
    var apiUrl = await '$adminBaseUrl${AppUrls.getAccountManagerList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future getRequestCallbackList(Map<String, dynamic> data) async {
    var adminBaseUrl = '';
    var apiUrl = await '$adminBaseUrl${AppUrls.getRequestCallbackList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future createRequestCallback(Map<String, dynamic> data) async {
    var adminBaseUrl = '';
    var apiUrl = await '$adminBaseUrl${AppUrls.requestCallbackSave}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future getTutorialsList(Map<String, dynamic> data) async {
    var adminBaseUrl = '';
    var apiUrl = await '$adminBaseUrl${AppUrls.getTutorialsList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future getTutorialDetails(Map<String, dynamic> data) async {
    var adminBaseUrl = '';
    var apiUrl = await '$adminBaseUrl${AppUrls.getTutorialDetails}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future submitEmailSupportRequest(dynamic data) async {
    var apiUrl = await AppUrls.submitEmailSupportRequest;
    var response = await services.postFormData(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }
}
