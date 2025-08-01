class RestaurantOrderItemsModel {
  int? orderId;
  int? reservationId;
  String? orderNumber;
  int? orderStatusId;
  String? orderStatus;
  String? orderStatusBackgroundColor;
  String? orderStatusTextColor;
  String? orderStatusBorderColor;
  String? orderedAt;
  String? netTotal;
  List<RestaurantOrderedItemDishes>? dishes;

  RestaurantOrderItemsModel(
      {this.orderId,
      this.reservationId,
      this.orderNumber,
      this.orderStatus,
      this.orderStatusId,
      this.orderStatusBackgroundColor,
      this.orderStatusTextColor,
      this.orderStatusBorderColor,
      this.orderedAt,
      this.netTotal,
      this.dishes});

  RestaurantOrderItemsModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    reservationId = json['reservation_id'];
    orderNumber = json['order_number'];
    orderStatusId = json['order_status_id'];
    orderStatus = json['order_status'];
    orderStatusBackgroundColor = json['order_status_background_color'];
    orderStatusTextColor = json['order_status_text_color'];
    orderStatusBorderColor = json['order_status_border_color'];
    orderedAt = json['ordered_at'];
    netTotal = json['net_total'];
    if (json['dishes'] != null) {
      dishes = <RestaurantOrderedItemDishes>[];
      json['dishes'].forEach((v) {
        dishes!.add(new RestaurantOrderedItemDishes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['reservation_id'] = this.reservationId;
    data['order_number'] = this.orderNumber;
    data['order_status_id'] = this.orderStatusId;
    data['order_status'] = this.orderStatus;
    data['order_status_background_color'] = this.orderStatusBackgroundColor;
    data['order_status_text_color'] = this.orderStatusTextColor;
    data['order_status_border_color'] = this.orderStatusBorderColor;
    data['ordered_at'] = this.orderedAt;
    data['net_total'] = this.netTotal;
    if (this.dishes != null) {
      data['dishes'] = this.dishes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantOrderedItemDishes {
  int? dishId;
  int? menuDishMappingId;
  int? restaurantOrderMenuDishId;
  String? kitchen;
  dynamic station;
  String? dishPrice;
  String? dishName;
  int? quantity;
  int? dishStatusId;
  String? dishStatus;
  String? dishStatusBackgroundColor;
  String? dishStatusBorderColor;
  String? dishStatusTextColor;
  List<RestaurantOrderedItemVariants>? variants;
  List<RestaurantOrderedItemCustomizations>? customizations;

  RestaurantOrderedItemDishes(
      {this.dishId,
      this.menuDishMappingId,
      this.kitchen,
      this.station,
      this.dishPrice,
      this.dishName,
      this.quantity,
      this.dishStatusId,
      this.dishStatus,
      this.dishStatusBackgroundColor,
      this.dishStatusBorderColor,
      this.dishStatusTextColor,
      this.variants,
      this.restaurantOrderMenuDishId,
      this.customizations});

  RestaurantOrderedItemDishes.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    restaurantOrderMenuDishId = json['restaurant_order_menu_dish_id'];
    menuDishMappingId = json['menu_dish_mapping_id'];
    kitchen = json['kitchen'];
    station = json['station'];
    dishPrice = json['dish_price'];
    dishName = json['dish_name'];
    quantity = json['quantity'];
    dishStatusId = json['dish_status_id'];
    dishStatus = json['dish_status'];
    dishStatusBackgroundColor = json['dish_status_background_color'];
    dishStatusBorderColor = json['dish_status_border_color'];
    dishStatusTextColor = json['dish_status_text_color'];
    if (json['variants'] != null) {
      variants = <RestaurantOrderedItemVariants>[];
      json['variants'].forEach((v) {
        variants!.add(new RestaurantOrderedItemVariants.fromJson(v));
      });
    }
    if (json['customizations'] != null) {
      customizations = <RestaurantOrderedItemCustomizations>[];
      json['customizations'].forEach((v) {
        customizations!
            .add(new RestaurantOrderedItemCustomizations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dish_id'] = this.dishId;
    data['restaurant_order_menu_dish_id'] = this.restaurantOrderMenuDishId;
    data['menu_dish_mapping_id'] = this.menuDishMappingId;
    data['kitchen'] = this.kitchen;
    data['station'] = this.station;
    data['dish_price'] = this.dishPrice;
    data['dish_name'] = this.dishName;
    data['quantity'] = this.quantity;
    data['dish_status_id'] = this.dishStatusId;
    data['dish_status'] = this.dishStatus;
    data['dish_status_background_color'] = this.dishStatusBackgroundColor;
    data['dish_status_border_color'] = this.dishStatusBorderColor;
    data['dish_status_text_color'] = this.dishStatusTextColor;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.customizations != null) {
      data['customizations'] =
          this.customizations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantOrderedItemVariants {
  int? variantId;
  int? menuVariantId;
  String? variantPrice;
  int? quantity;
  List<RestaurantOrderedItemCustomizations>? customizations;

  RestaurantOrderedItemVariants(
      {this.variantId,
      this.menuVariantId,
      this.variantPrice,
      this.quantity,
      this.customizations});

  RestaurantOrderedItemVariants.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    menuVariantId = json['menu_variant_id'];
    variantPrice = json['variant_price'];
    quantity = json['quantity'];
    if (json['customizations'] != null) {
      customizations = <RestaurantOrderedItemCustomizations>[];
      json['customizations'].forEach((v) {
        customizations!
            .add(new RestaurantOrderedItemCustomizations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_id'] = this.variantId;
    data['menu_variant_id'] = this.menuVariantId;
    data['variant_price'] = this.variantPrice;
    data['quantity'] = this.quantity;
    if (this.customizations != null) {
      data['customizations'] =
          this.customizations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantOrderedItemCustomizations {
  int? customizationId;
  int? addonId;
  String? addonPrice;
  int? quantity;

  RestaurantOrderedItemCustomizations(
      {this.customizationId, this.addonId, this.addonPrice, this.quantity});

  RestaurantOrderedItemCustomizations.fromJson(Map<String, dynamic> json) {
    customizationId = json['customization_id'];
    addonId = json['addon_id'];
    addonPrice = json['addon_price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customization_id'] = this.customizationId;
    data['addon_id'] = this.addonId;
    data['addon_price'] = this.addonPrice;
    data['quantity'] = this.quantity;
    return data;
  }
}
