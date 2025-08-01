class RestaurantDataModel {
  int? restaurantId;
  String? restaurantName;
  String? currencySymbol;
  List<RestaurantAreas>? restaurantAreas;

  RestaurantDataModel(
      {this.restaurantId, this.restaurantName, this.restaurantAreas});

  RestaurantDataModel.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    currencySymbol = json['currency_symbol'];
    if (json['restaurant_areas'] != null) {
      restaurantAreas = <RestaurantAreas>[];
      json['restaurant_areas'].forEach((v) {
        restaurantAreas!.add(new RestaurantAreas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_name'] = this.restaurantName;
    data['currency_symbol'] = this.currencySymbol;
    if (this.restaurantAreas != null) {
      data['restaurant_areas'] =
          this.restaurantAreas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantAreas {
  int? restaurantAreaId;
  String? restaurantAreaName;
  List<RestaurantTables>? tables;

  RestaurantAreas(
      {this.restaurantAreaId, this.restaurantAreaName, this.tables});

  RestaurantAreas.fromJson(Map<String, dynamic> json) {
    restaurantAreaId = json['restaurant_area_id'];
    restaurantAreaName = json['restaurant_area_name'];
    if (json['tables'] != null) {
      tables = <RestaurantTables>[];
      json['tables'].forEach((v) {
        tables!.add(new RestaurantTables.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_area_id'] = this.restaurantAreaId;
    data['restaurant_area_name'] = this.restaurantAreaName;
    if (this.tables != null) {
      data['tables'] = this.tables!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantTables {
  int? restaurantTableId;
  String? tableName;
  int? seatingCapacity;
  String? privacyLevel;
  int? wheelchairAccessible;
  int? childFriendly;
  int? smokingAllowed;
  int? petFriendly;
  String? occupancyStatus;
  String? occupancyStatusTextColor;
  String? occupancyStatusBackgroundColor;
  String? occupancyStatusBorderColor;
  int? restaurantReservationId;

  RestaurantTables(
      {this.restaurantTableId,
      this.tableName,
      this.seatingCapacity,
      this.privacyLevel,
      this.wheelchairAccessible,
      this.childFriendly,
      this.smokingAllowed,
      this.petFriendly,
      this.occupancyStatus,
      this.occupancyStatusTextColor,
      this.occupancyStatusBackgroundColor,
      this.occupancyStatusBorderColor,
      this.restaurantReservationId});

  RestaurantTables.fromJson(Map<String, dynamic> json) {
    restaurantTableId = json['restaurant_table_id'];
    tableName = json['table_name'];
    seatingCapacity = json['seating_capacity'];
    privacyLevel = json['privacy_level'];
    wheelchairAccessible = json['wheelchair_accessible'];
    childFriendly = json['child_friendly'];
    smokingAllowed = json['smoking_allowed'];
    petFriendly = json['pet_friendly'];
    occupancyStatus = json['occupancy_status'];
    occupancyStatusTextColor = json['occupancy_status_text_color'];
    occupancyStatusBackgroundColor = json['occupancy_status_background_color'];
    occupancyStatusBorderColor = json['occupancy_status_border_color'];
    restaurantReservationId = json['restaurant_reservation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_table_id'] = this.restaurantTableId;
    data['table_name'] = this.tableName;
    data['seating_capacity'] = this.seatingCapacity;
    data['privacy_level'] = this.privacyLevel;
    data['wheelchair_accessible'] = this.wheelchairAccessible;
    data['child_friendly'] = this.childFriendly;
    data['smoking_allowed'] = this.smokingAllowed;
    data['pet_friendly'] = this.petFriendly;
    data['occupancy_status'] = this.occupancyStatus;
    data['occupancy_status_text_color'] = this.occupancyStatusTextColor;
    data['occupancy_status_background_color'] =
        this.occupancyStatusBackgroundColor;
    data['occupancy_status_border_color'] = this.occupancyStatusBorderColor;
    data['restaurant_reservation_id'] = this.restaurantReservationId;
    return data;
  }
}
