import '../../app/app.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantApiServices apis;
  RestaurantRepositoryImpl({required this.apis});

  @override
  Future getRestaurantList({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await apis.getRestaurantList(
        data: data,
        token: token,
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getRestaurantStatus({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await apis.getRestaurantStatus(
        data: data,
        token: token,
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getRestaurantData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await apis.getRestaurantData(
        data: data,
        token: token,
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getRestaurantTableData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await apis.getRestaurantTableData(
        data: data,
        token: token,
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getRestaurantDishData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await apis.getRestaurantDishData(
        data: data,
        token: token,
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getKotData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await apis.getKotData(
        data: data,
        token: token,
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future checkCartData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await apis.checkCartData(
        data: data,
        token: token,
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future placeOrder({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await apis.placeOrder(
        data: data,
        token: token,
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future removeKot({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await apis.removeKot(
        data: data,
        token: token,
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }
}
