import '../../app/app.dart';

class RestaurantApiServices {
  final NetworkServices services;
  RestaurantApiServices({required this.services});

  Future getRestaurantList({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    var phaseTwoBaseUrl = '';
    var apiUrl = '$phaseTwoBaseUrl${AppUrls.getRestaurantList}';
    var response = await services.post(
      path: apiUrl,
      data: data,
      token: token,
      header: headers,
    );
    return RestaurantGenericResponse.fromJson(response);
  }

  Future getRestaurantStatus({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    var phaseTwoBaseUrl = '';
    var apiUrl = '$phaseTwoBaseUrl${AppUrls.getRestaurantStatus}';
    var response = await services.post(
      path: apiUrl,
      data: data,
      token: token,
      header: headers,
    );

    return RestaurantGenericResponse.fromJson(response);
  }

  Future getRestaurantData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    var phaseTwoBaseUrl = '';
    var apiUrl = '$phaseTwoBaseUrl${AppUrls.getRestaurantData}';
    var response = await services.post(
      path: apiUrl,
      data: data,
      token: token,
      header: headers,
    );

    return RestaurantGenericResponse.fromJson(response);
  }

  Future getRestaurantTableData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    var phaseTwoBaseUrl = '';
    var apiUrl = '$phaseTwoBaseUrl${AppUrls.getRestaurantTableData}';
    var response = await services.post(
      path: apiUrl,
      data: data,
      token: token,
      header: headers,
    );

    return RestaurantGenericResponse.fromJson(response);
  }

  Future getRestaurantDishData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    var phaseTwoBaseUrl = '';
    var apiUrl = '$phaseTwoBaseUrl${AppUrls.getRestaurantDishData}';
    var response = await services.post(
      path: apiUrl,
      data: data,
      token: token,
      header: headers,
    );

    return RestaurantGenericResponse.fromJson(response);
  }

  Future getKotData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    var phaseTwoBaseUrl = '';
    var apiUrl = '$phaseTwoBaseUrl${AppUrls.getKotData}';
    var response = await services.post(
      path: apiUrl,
      data: data,
      token: token,
      header: headers,
    );

    return RestaurantGenericResponse.fromJson(response);
  }

  Future checkCartData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    var phaseTwoBaseUrl = '';
    var apiUrl = '$phaseTwoBaseUrl${AppUrls.checkCartData}';
    var response = await services.post(
      path: apiUrl,
      data: data,
      token: token,
      header: headers,
    );

    return RestaurantGenericResponse.fromJson(response);
  }

  Future placeOrder({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    var phaseTwoBaseUrl = '';
    var apiUrl = '$phaseTwoBaseUrl${AppUrls.placeOrder}';
    var response = await services.post(
      path: apiUrl,
      data: data,
      token: token,
      header: headers,
    );

    return RestaurantGenericResponse.fromJson(response);
  }

  Future removeKot({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    var phaseTwoBaseUrl = '';
    var apiUrl = '$phaseTwoBaseUrl${AppUrls.removeKot}';
    var response = await services.post(
      path: apiUrl,
      data: data,
      token: token,
      header: headers,
    );

    return RestaurantGenericResponse.fromJson(response);
  }
}
