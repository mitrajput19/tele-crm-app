class TaskStepCollectAddItemDetails {
  int? internalRoomId;
  String? internalRoomName;
  List<TaskStepCollectAddItemHousekeepingProducts>? housekeepingProducts;

  TaskStepCollectAddItemDetails({
    this.internalRoomId,
    this.internalRoomName,
    this.housekeepingProducts,
  });

  TaskStepCollectAddItemDetails.fromJson(Map<String, dynamic> json) {
    internalRoomId = json['internal_room_id'];
    internalRoomName = json['internal_room_name'];
    if (json['housekeeping_products'] != null) {
      housekeepingProducts = <TaskStepCollectAddItemHousekeepingProducts>[];
      json['housekeeping_products'].forEach((v) {
        housekeepingProducts!.add(new TaskStepCollectAddItemHousekeepingProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['internal_room_id'] = this.internalRoomId;
    data['internal_room_name'] = this.internalRoomName;
    if (this.housekeepingProducts != null) {
      data['housekeeping_products'] = this.housekeepingProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<TaskStepCollectAddItemDetails> listFromJson(dynamic json) {
    List<TaskStepCollectAddItemDetails> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new TaskStepCollectAddItemDetails.fromJson(v));
      });
    }
    return list;
  }
}

class TaskStepCollectAddItemHousekeepingProducts {
  int? housekeepingProductsInRoomId;
  int? productId;
  String? productName;
  int? requiredQuantity;
  int? currentQuantity;
  int? taskResponseSubmitted;
  int? taskResponseItemsCollectedQuantity;
  int? taskResponseItemsAddedQuantity;

  TaskStepCollectAddItemHousekeepingProducts({
    this.housekeepingProductsInRoomId,
    this.productId,
    this.productName,
    this.requiredQuantity,
    this.currentQuantity,
    this.taskResponseSubmitted,
    this.taskResponseItemsCollectedQuantity,
    this.taskResponseItemsAddedQuantity,
  });

  TaskStepCollectAddItemHousekeepingProducts.fromJson(Map<String, dynamic> json) {
    housekeepingProductsInRoomId = json['housekeeping_products_in_room_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    requiredQuantity = json['required_quantity'];
    currentQuantity = json['current_quantity'];
    taskResponseSubmitted = json['task_response_submitted'];
    taskResponseItemsCollectedQuantity = json['task_response_items_collected_quantity'];
    taskResponseItemsAddedQuantity = json['task_response_items_added_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['housekeeping_products_in_room_id'] = this.housekeepingProductsInRoomId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['required_quantity'] = this.requiredQuantity;
    data['current_quantity'] = this.currentQuantity;
    data['task_response_submitted'] = this.taskResponseSubmitted;
    data['task_response_items_collected_quantity'] = this.taskResponseItemsCollectedQuantity;
    data['task_response_items_added_quantity'] = this.taskResponseItemsAddedQuantity;
    return data;
  }
}
