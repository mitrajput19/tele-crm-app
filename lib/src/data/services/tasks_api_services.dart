import '../../app/app.dart';

class TasksApiServices {
  final NetworkServices services;
  TasksApiServices({required this.services});

  Future getEmployeeTasksList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeTasksList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeTaskDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeTaskDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getEmployeeTaskStepDetails(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getEmployeeTaskStepDetails,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future updateEmployeeTaskStatus(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.updateEmployeeTaskStatus,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future updateEmployeeTaskStepStatus(dynamic data) async {
    var response = await services.post(
      path: AppUrls.updateEmployeeTaskStepStatus,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getTaskRequestTypeList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getMakeRequestTypeList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getGeneralPriorityList(Map<String, dynamic> data) async {
    var masterBaseUrl = '';
    var apiUrl = await '$masterBaseUrl${AppUrls.getGeneralPriorityList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getTaskRequestList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.taskMakeRequestList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future submitTaskMakeRequest(dynamic data) async {
    var response = await services.post(
      path: AppUrls.submitTaskMakeRequest,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }
}
