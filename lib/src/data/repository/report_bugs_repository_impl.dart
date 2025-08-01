import '../../app/app.dart';

class BugReportRepositoryImpl implements BugReportRepository {
  final BugReportApiServices apis;
  BugReportRepositoryImpl({required this.apis});

  @override
  Future getBugLabelList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.getBugLabelList(data);
      if (response.success == 1) {
        var responseData = BugLabel.listFromJson(response.data);
        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getBugStatusList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.getBugStatusList(data);
      if (response.success == 1) {
        var responseData = BugStatus.listFromJson(response.data);
        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getBugPriorityList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.getBugPriorityList(data);
      if (response.success == 1) {
        var responseData = BugPriority.listFromJson(response.data);
        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getBugSeverityList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.getBugSeverityList(data);
      if (response.success == 1) {
        var responseData = BugSeverity.listFromJson(response.data);
        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getBugDeviceList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apis.getBugDeviceList(data);
      if (response.success == 1) {
        var responseData = BugDevice.listFromJson(response.data);
        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getBugReportedList(Map<String, dynamic> data) async {
    try {
      AdminGenericResponse response = await apis.getBugReportedList(data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getBugReportDetails(Map<String, dynamic> data) async {
    try {
      AdminGenericResponse response = await apis.getBugReportDetails(data);
      if (response.error == 0) {
        var responseData = BugReported.fromJson(response.data);
        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future createBugReport(dynamic data) async {
    try {
      AdminGenericResponse response = await apis.createBugReport(data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future createBugFollowUp(dynamic data) async {
    try {
      AdminGenericResponse response = await apis.createBugFollowUp(data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
