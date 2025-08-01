import '../../app/app.dart';

class ContactsApiServices {
  final NetworkServices services;
  ContactsApiServices({required this.services});

  Future getContactsList(Map<String, dynamic> data) async {
    var apiUrl = AppUrls.messageApi;
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future getContactChatsList(Map<String, dynamic> data) async {
    var apiUrl = AppUrls.messageApi;
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future sendMessage(Map<String, dynamic> data) async {
    var apiUrl = AppUrls.messageApi;
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future sendFile(dynamic data) async {
    var apiUrl = AppUrls.messageApi;
    var response = await services.postFormData(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future readMessageStatus(Map<String, dynamic> data) async {
    var apiUrl = AppUrls.messageApi;
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return AdminGenericResponse.fromJson(response);
  }

  Future getEmployeeSubordinatesList(Map<String, dynamic> data) async {
    var apiUrl = AppUrls.getEmployeeSubordinatesList;
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future uploadChatFiles(dynamic data) async {
    var apiUrl = AppUrls.uploadChatFiles;
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }
}
