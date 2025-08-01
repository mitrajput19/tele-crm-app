class RestaurantMenuModel {
  Reservation? reservation;
  List<RestaurantMenus>? menus;

  RestaurantMenuModel({this.reservation, this.menus});

  RestaurantMenuModel.fromJson(Map<String, dynamic> json) {
    reservation = json['reservation'] != null
        ? new Reservation.fromJson(json['reservation'])
        : null;
    if (json['menus'] != null) {
      menus = <RestaurantMenus>[];
      json['menus'].forEach((v) {
        menus!.add(new RestaurantMenus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reservation != null) {
      data['reservation'] = this.reservation!.toJson();
    }
    if (this.menus != null) {
      data['menus'] = this.menus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reservation {
  String? reservationNumber;
  String? reservationStatus;
  int? guestPartySize;
  String? restaurantReservationDate;
  List? specialRequests;
  List<RestaurantTableDetails>? tableDetails;

  Reservation(
      {this.reservationNumber,
      this.reservationStatus,
      this.guestPartySize,
      this.restaurantReservationDate,
      this.specialRequests,
      this.tableDetails});

  Reservation.fromJson(Map<String, dynamic> json) {
    reservationNumber = json['reservation_number'];
    reservationStatus = json['reservation_status'];
    guestPartySize = json['guest_party_size'];
    restaurantReservationDate = json['restaurant_reservation_date'];
    // if (json['special_requests'] != null) {
    //   specialRequests = <Null>[];
    //   json['special_requests'].forEach((v) {
    //     specialRequests!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['table_details'] != null) {
      tableDetails = <RestaurantTableDetails>[];
      json['table_details'].forEach((v) {
        tableDetails!.add(new RestaurantTableDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reservation_number'] = this.reservationNumber;
    data['reservation_status'] = this.reservationStatus;
    data['guest_party_size'] = this.guestPartySize;
    data['restaurant_reservation_date'] = this.restaurantReservationDate;
    if (this.specialRequests != null) {
      data['special_requests'] =
          this.specialRequests!.map((v) => v.toJson()).toList();
    }
    if (this.tableDetails != null) {
      data['table_details'] =
          this.tableDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantTableDetails {
  int? restaurantReservationTableDetailId;
  int? restaurantTableId;
  String? occupancyStatus;
  String? occupancyStatusTextColor;
  String? occupancyStatusBackgroundColor;
  String? occupancyStatusBorderColor;
  String? bookingTimeFrom;
  String? bookingTimeUntil;

  RestaurantTableDetails(
      {this.restaurantReservationTableDetailId,
      this.restaurantTableId,
      this.occupancyStatus,
      this.occupancyStatusTextColor,
      this.occupancyStatusBackgroundColor,
      this.occupancyStatusBorderColor,
      this.bookingTimeFrom,
      this.bookingTimeUntil});

  RestaurantTableDetails.fromJson(Map<String, dynamic> json) {
    restaurantReservationTableDetailId =
        json['restaurant_reservation_table_detail_id'];
    restaurantTableId = json['restaurant_table_id'];
    occupancyStatus = json['occupancy_status'];
    occupancyStatusTextColor = json['occupancy_status_text_color'];
    occupancyStatusBackgroundColor = json['occupancy_status_background_color'];
    occupancyStatusBorderColor = json['occupancy_status_border_color'];
    bookingTimeFrom = json['booking_time_from'];
    bookingTimeUntil = json['booking_time_until'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_reservation_table_detail_id'] =
        this.restaurantReservationTableDetailId;
    data['restaurant_table_id'] = this.restaurantTableId;
    data['occupancy_status'] = this.occupancyStatus;
    data['occupancy_status_text_color'] = this.occupancyStatusTextColor;
    data['occupancy_status_background_color'] =
        this.occupancyStatusBackgroundColor;
    data['occupancy_status_border_color'] = this.occupancyStatusBorderColor;
    data['booking_time_from'] = this.bookingTimeFrom;
    data['booking_time_until'] = this.bookingTimeUntil;
    return data;
  }
}

class RestaurantMenus {
  int? restaurantMenuId;
  String? restaurantMenuName;
  int? isDefaultMenu;
  List<RestaurantCategories>? categories;

  RestaurantMenus(
      {this.restaurantMenuId,
      this.restaurantMenuName,
      this.isDefaultMenu,
      this.categories});

  RestaurantMenus.fromJson(Map<String, dynamic> json) {
    restaurantMenuId = json['restaurant_menu_id'];
    restaurantMenuName = json['restaurant_menu_name'];
    isDefaultMenu = json['is_default_menu'];
    if (json['categories'] != null) {
      categories = <RestaurantCategories>[];
      json['categories'].forEach((v) {
        categories!.add(new RestaurantCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_menu_id'] = this.restaurantMenuId;
    data['restaurant_menu_name'] = this.restaurantMenuName;
    data['is_default_menu'] = this.isDefaultMenu;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantCategories {
  int? restaurantMenuCategoryId;
  String? restaurantMenuCategoryTitle;
  int? isPriceApplicableToTheEntireCategory;
  String? imageUrl;
  int? displayPrice;
  String? sellingPrice;
  int? dishCount;

  RestaurantCategories({
    this.restaurantMenuCategoryId,
    this.restaurantMenuCategoryTitle,
    this.isPriceApplicableToTheEntireCategory,
    this.imageUrl,
    this.displayPrice,
    this.sellingPrice,
    this.dishCount,
  });

  RestaurantCategories.fromJson(Map<String, dynamic> json) {
    restaurantMenuCategoryId = json['restaurant_menu_category_id'];
    restaurantMenuCategoryTitle = json['restaurant_menu_category_title'];
    isPriceApplicableToTheEntireCategory =
        json['is_price_applicable_to_the_entire_category'];
    imageUrl = json['image_url'];
    displayPrice = json['display_price'];
    sellingPrice = json['selling_price'];
    dishCount = json['dish_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_menu_category_id'] = this.restaurantMenuCategoryId;
    data['restaurant_menu_category_title'] = this.restaurantMenuCategoryTitle;
    data['is_price_applicable_to_the_entire_category'] =
        this.isPriceApplicableToTheEntireCategory;
    data['image_url'] = this.imageUrl;
    data['display_price'] = this.displayPrice;
    data['selling_price'] = this.sellingPrice;
    data['dish_count'] = this.dishCount;
    return data;
  }
}
