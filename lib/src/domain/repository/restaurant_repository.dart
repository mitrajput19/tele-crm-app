abstract class RestaurantRepository {
  Future getRestaurantList({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  });
  Future getRestaurantStatus({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  });
  Future getRestaurantData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  });
  Future getRestaurantTableData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  });
  Future getRestaurantDishData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  });
  Future getKotData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  });
  Future placeOrder({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  });
  Future checkCartData({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  });
  Future removeKot({
    required Map<String, dynamic> data,
    required String token,
    Map<String, dynamic>? headers,
  });
}
