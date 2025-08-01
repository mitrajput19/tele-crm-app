import '../../app/app.dart';

class ProfileApiServices {
  final NetworkServices services;
  ProfileApiServices({required this.services});

  Future getEmployeePersonalDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeContactDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeEmergencyContactDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeDependentDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeDocumentDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeEligibilityDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeWorkDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeSkillDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeQualificationDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeCertificationDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeCareerHistoryDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeCompanyPropertyDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeePayslipDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeePayslipDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeExpensesList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeExpensesList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }
}
