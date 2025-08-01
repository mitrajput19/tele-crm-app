import '../../app/app.dart';

class ShiftsApiServices {
  final NetworkServices services;
  ShiftsApiServices({required this.services});

  Future<GenericResponse> getEmployeeShiftsList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeShiftsList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> getEmployeeShiftDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeShiftDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> updateShiftTimeKeepingStatus(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.updateShiftTimeKeepingStatus,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> getEmployeeOpenShiftsList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeOpenShiftsList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> getEmployeeAttendanceReport(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeAttendanceReport,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> updatePickUpOpenShift(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.updatePickUpOpenShift,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }
}
