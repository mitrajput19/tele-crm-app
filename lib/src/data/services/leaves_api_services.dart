import '../../app/app.dart';

class LeavesApiServices {
  final NetworkServices services;
  LeavesApiServices({required this.services});

  Future getLeaveReasonList(Map<String, dynamic> data) async {
    var masterBaseUrl = '';
    var apiUrl = await '$masterBaseUrl${AppUrls.getShiftLeaveReasonList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future submitEmployeeHolidayRequest(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.submitEmployeeHolidayRequest,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future submitEmployeeLeaveRequest(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.submitEmployeeLeavesRequest,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeLeavesList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeLeavesList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeHolidaysList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeHolidaysList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getHolidayApprovalRequestsList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getHolidayApprovalRequestsList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getLeaveApprovalRequestsList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getLeaveApprovalRequestsList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future submitHolidayApprovalRequest(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.submitHolidayApprovalRequest,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future submitLeaveApprovalRequest(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.submitLeaveApprovalRequest,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }
}
