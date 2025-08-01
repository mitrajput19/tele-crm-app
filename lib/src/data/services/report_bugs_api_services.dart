import '../../app/app.dart';

class BugReportApiServices {
  final NetworkServices services;
  BugReportApiServices({required this.services});

  Future getBugReportedList(Map<String, dynamic> data) async {
    var adminBaseUrl = '';
    var apiUrl = await '$adminBaseUrl${AppUrls.getBugReportList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future getBugLabelList(Map<String, dynamic> data) async {
    var masterBaseUrl = '';
    var apiUrl = await '$masterBaseUrl${AppUrls.getBugLabelList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getBugStatusList(Map<String, dynamic> data) async {
    var masterBaseUrl = '';
    var apiUrl = await '$masterBaseUrl${AppUrls.getBugStatusList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getBugPriorityList(Map<String, dynamic> data) async {
    var masterBaseUrl = '';
    var apiUrl = await '$masterBaseUrl${AppUrls.getBugPriorityList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getBugSeverityList(Map<String, dynamic> data) async {
    var masterBaseUrl = '';
    var apiUrl = await '$masterBaseUrl${AppUrls.getBugSeverityList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getBugDeviceList(Map<String, dynamic> data) async {
    var masterBaseUrl = '';
    var apiUrl = await '$masterBaseUrl${AppUrls.getBugDeviceList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future createBugReport(dynamic data) async {
    var adminBaseUrl ='';
    var apiUrl = await '$adminBaseUrl${AppUrls.createBugReport}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future getBugReportDetails(Map<String, dynamic> data) async {
    var adminBaseUrl ='';
    var apiUrl = await '$adminBaseUrl${AppUrls.getBugReportDetails}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future createBugFollowUp(dynamic data) async {
    var adminBaseUrl ='';
    var apiUrl = await '$adminBaseUrl${AppUrls.createBugReportFollowUp}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }
}
