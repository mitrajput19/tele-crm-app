class RestaurantDishModel {
  int? restaurantMenuDishMappingId;
  int? restaurantDishId;
  int? restaurantMenuCategoryId;
  String? dishPrice;
  RestaurantDish? dish;
  List<RestaurantDishVariants>? variants;
  List<RestaurantDishCustomizations>? customizations;
  RestaurantKitchen? kitchen;

  RestaurantDishModel(
      {this.restaurantMenuDishMappingId,
      this.restaurantDishId,
      this.restaurantMenuCategoryId,
      this.dish,
      this.variants,
      this.customizations,
      this.dishPrice,
      this.kitchen});

  RestaurantDishModel.fromJson(Map<String, dynamic> json) {
    restaurantMenuDishMappingId = json['restaurant_menu_dish_mapping_id'];
    restaurantDishId = json['restaurant_dish_id'];
    restaurantMenuCategoryId = json['restaurant_menu_category_id'];
    dishPrice = json['dish_price'];
    dish = json['dish'] != null ? new RestaurantDish.fromJson(json['dish']) : null;
    if (json['variants'] != null) {
      variants = <RestaurantDishVariants>[];
      json['variants'].forEach((v) {
        variants!.add(new RestaurantDishVariants.fromJson(v));
      });
    }
    if (json['customizations'] != null) {
      customizations = <RestaurantDishCustomizations>[];
      json['customizations'].forEach((v) {
        customizations!.add(new RestaurantDishCustomizations.fromJson(v));
      });
    }
    kitchen = json['kitchen'] != null ? new RestaurantKitchen.fromJson(json['kitchen']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_menu_dish_mapping_id'] = this.restaurantMenuDishMappingId;
    data['restaurant_dish_id'] = this.restaurantDishId;
    data['restaurant_menu_category_id'] = this.restaurantMenuCategoryId;
    data['dish_price'] = this.dishPrice;
    if (this.dish != null) {
      data['dish'] = this.dish!.toJson();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.customizations != null) {
      data['customizations'] = this.customizations!.map((v) => v.toJson()).toList();
    }
    if (this.kitchen != null) {
      data['kitchen'] = this.kitchen!.toJson();
    }
    return data;
  }
}

class RestaurantDish {
  int? restaurantDishId;
  String? dishName;
  String? dishDescription;
  String? imageUrl;

  RestaurantDish({this.restaurantDishId, this.dishName, this.imageUrl});

  RestaurantDish.fromJson(Map<String, dynamic> json) {
    restaurantDishId = json['restaurant_dish_id'];
    dishName = json['dish_name'];
    dishDescription = json['dish_description'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_dish_id'] = this.restaurantDishId;
    data['dish_name'] = this.dishName;
    data['dish_description'] = this.dishDescription;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class RestaurantDishVariants {
  int? variantId;
  String? variantTitle;
  String? variantSubtitle;
  RestaurantDishPrices? prices;
  List<RestaurantDishCustomizations>? customizations;

  RestaurantDishVariants({this.variantId, this.variantTitle, this.variantSubtitle, this.prices, this.customizations});

  RestaurantDishVariants.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    variantTitle = json['variant_title'];
    variantSubtitle = json['variant_subtitle'];
    prices = json['price'] != null ? new RestaurantDishPrices.fromJson(json['price']) : null;
    if (json['customizations'] != null) {
      customizations = <RestaurantDishCustomizations>[];
      json['customizations'].forEach((v) {
        customizations!.add(new RestaurantDishCustomizations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_id'] = this.variantId;
    data['variant_title'] = this.variantTitle;
    data['variant_subtitle'] = this.variantSubtitle;
    if (this.prices != null) {
      data['price'] = this.prices!.toJson();
    }
    if (this.customizations != null) {
      data['customizations'] = this.customizations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantDishPrices {
  int? restaurantDishVariantId;
  int? restaurantMenuDishMappingId;
  int? displayPrice;
  String? sellingPrice;
  int? isVariantActive;

  RestaurantDishPrices(
      {this.restaurantDishVariantId,
      this.restaurantMenuDishMappingId,
      this.displayPrice,
      this.sellingPrice,
      this.isVariantActive});

  RestaurantDishPrices.fromJson(Map<String, dynamic> json) {
    restaurantDishVariantId = json['restaurant_dish_variant_id'];
    restaurantMenuDishMappingId = json['restaurant_menu_dish_mapping_id'];
    displayPrice = json['display_price'];
    sellingPrice = json['selling_price'];
    isVariantActive = json['is_variant_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_dish_variant_id'] = this.restaurantDishVariantId;
    data['restaurant_menu_dish_mapping_id'] = this.restaurantMenuDishMappingId;
    data['display_price'] = this.displayPrice;
    data['selling_price'] = this.sellingPrice;
    data['is_variant_active'] = this.isVariantActive;
    return data;
  }
}

class RestaurantDishCustomizations {
  int? customizationAddonId;
  String? customizationTitle;
  String? customizationSubtitle;
  int? isSelectionMandatory;
  int? minimumSelections;
  int? maximumSelections;
  List<RestaurantDishAddons>? addons;

  RestaurantDishCustomizations(
      {this.customizationAddonId,
      this.customizationTitle,
      this.customizationSubtitle,
      this.isSelectionMandatory,
      this.minimumSelections,
      this.maximumSelections,
      this.addons});

  RestaurantDishCustomizations.fromJson(Map<String, dynamic> json) {
    customizationAddonId = json['customization_addon_id'];
    customizationTitle = json['customization_title'];
    customizationSubtitle = json['customization_subtitle'];
    isSelectionMandatory = json['is_selection_mandatory'];
    minimumSelections = json['minimum_selections'];
    maximumSelections = json['maximum_selections'];
    if (json['addons'] != null) {
      addons = <RestaurantDishAddons>[];
      json['addons'].forEach((v) {
        addons!.add(new RestaurantDishAddons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customization_addon_id'] = this.customizationAddonId;
    data['customization_title'] = this.customizationTitle;
    data['customization_subtitle'] = this.customizationSubtitle;
    data['is_selection_mandatory'] = this.isSelectionMandatory;
    data['minimum_selections'] = this.minimumSelections;
    data['maximum_selections'] = this.maximumSelections;
    if (this.addons != null) {
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantDishAddons {
  int? addonDetailId;
  String? addonsDetailName;
  String? dietaryCategoryName;
  String? topUpSellingPrice;

  RestaurantDishAddons({this.addonDetailId, this.addonsDetailName, this.dietaryCategoryName, this.topUpSellingPrice});

  RestaurantDishAddons.fromJson(Map<String, dynamic> json) {
    addonDetailId = json['addon_detail_id'];
    addonsDetailName = json['addons_detail_name'];
    dietaryCategoryName = json['dietary_category_name'];
    topUpSellingPrice = json['top_up_selling_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addon_detail_id'] = this.addonDetailId;
    data['addons_detail_name'] = this.addonsDetailName;
    data['dietary_category_name'] = this.dietaryCategoryName;
    data['top_up_selling_price'] = this.topUpSellingPrice;
    return data;
  }
}

class RestaurantKitchen {
  int? restaurantKitchenId;
  String? restaurantKitchenName;
  int? maxOrderCapacity;

  RestaurantKitchen({this.restaurantKitchenId, this.restaurantKitchenName, this.maxOrderCapacity});

  RestaurantKitchen.fromJson(Map<String, dynamic> json) {
    restaurantKitchenId = json['restaurant_kitchen_id'];
    restaurantKitchenName = json['restaurant_kitchen_name'];
    maxOrderCapacity = json['max_order_capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_kitchen_id'] = this.restaurantKitchenId;
    data['restaurant_kitchen_name'] = this.restaurantKitchenName;
    data['max_order_capacity'] = this.maxOrderCapacity;
    return data;
  }
}
