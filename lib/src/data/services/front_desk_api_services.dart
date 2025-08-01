import '../../app/app.dart';

class FrontDeskApiServices {
  final NetworkServices services;
  FrontDeskApiServices({required this.services});

  Future getFrontDeskData(Map<String, dynamic> data) async {
    var apiUrl = AppUrls.getFrontDeskData;
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getRoomAvailabilityList(Map<String, dynamic> data) async {
    var apiUrl = AppUrls.getRoomAvailabilityList;
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getRevenueManagementList(Map<String, dynamic> data) async {
    var apiUrl = AppUrls.getRevenueManagementList;
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getRoomReservationsList(Map<String, dynamic> data) async {
    var apiUrl = AppUrls.getRoomReservationsList;
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future getPropertyTransactionsList(Map<String, dynamic> data) async {
    var apiUrl = AppUrls.getPropertyTransactionsList;
    var response = await services.post(
      path: apiUrl,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }
}
