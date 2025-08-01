class RestaurantModel {
  int? restaurantId;
  String? restaurantName;
  int? propertyId;
  String? restaurantDescription;

  RestaurantModel({
    this.restaurantId,
    this.restaurantName,
    this.restaurantDescription,
    this.propertyId,
  });

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    propertyId = json['property_id'];
    restaurantDescription = json['restaurant_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_name'] = this.restaurantName;
    data['property_id'] = this.propertyId;
    data['restaurant_description'] = this.restaurantDescription;
    return data;
  }
}
