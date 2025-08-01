import '../../app/app.dart';

class HelpAndSupportRepositoryImpl implements HelpAndSupportRepository {
  final HelpAndSupportApiServices apis;
  HelpAndSupportRepositoryImpl({required this.apis});

  @override
  Future getFaqsList(Map<String, dynamic> data) async {
    try {
      AdminGenericResponse response = await apis.getFaqsList(data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getAccounManagerList(Map<String, dynamic> data) async {
    try {
      AdminGenericResponse response = await apis.getAccounManagerList(data);
      if (response.error == 0) {
        var responseData = AccounManager.listFromJson(response.data);
        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getRequestCallbackList(Map<String, dynamic> data) async {
    try {
      AdminGenericResponse response = await apis.getRequestCallbackList(data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future createRequestCallback(Map<String, dynamic> data) async {
    try {
      AdminGenericResponse response = await apis.createRequestCallback(data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getTutorialsList(Map<String, dynamic> data) async {
    try {
      AdminGenericResponse response = await apis.getTutorialsList(data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getTutorialDetails(Map<String, dynamic> data) async {
    try {
      AdminGenericResponse response = await apis.getTutorialDetails(data);
      if (response.error == 0) {
        var responseData = Tutorial.fromJson(response.data);
        return response.copyWith(data: responseData);
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future submitEmailSupportRequest(dynamic data) async {
    try {
      GenericResponse response = await apis.submitEmailSupportRequest(data);
      if (response.success == 1) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      throw e;
    }
  }
}
