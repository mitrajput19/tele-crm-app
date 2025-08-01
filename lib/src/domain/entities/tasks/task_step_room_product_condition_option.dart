class TaskStepRoomProductConditionOption {
  int? productStockConditionId;
  String? productStockConditionTextColor;
  String? productStockConditionBgColor;
  String? productStockConditionName;
  String? productStockConditionDescription;

  TaskStepRoomProductConditionOption({
    this.productStockConditionId,
    this.productStockConditionTextColor,
    this.productStockConditionBgColor,
    this.productStockConditionName,
    this.productStockConditionDescription,
  });

  TaskStepRoomProductConditionOption.fromJson(Map<String, dynamic> json) {
    productStockConditionId = json['product_stock_condition_id'];
    productStockConditionTextColor = json['product_stock_condition_text_color'];
    productStockConditionBgColor = json['product_stock_condition_bg_color'];
    productStockConditionName = json['product_stock_condition_name'];
    productStockConditionDescription = json['product_stock_condition_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_stock_condition_id'] = this.productStockConditionId;
    data['product_stock_condition_text_color'] = this.productStockConditionTextColor;
    data['product_stock_condition_bg_color'] = this.productStockConditionBgColor;
    data['product_stock_condition_name'] = this.productStockConditionName;
    data['product_stock_condition_description'] = this.productStockConditionDescription;
    return data;
  }

  static List<TaskStepRoomProductConditionOption> listFromJson(dynamic json) {
    List<TaskStepRoomProductConditionOption> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new TaskStepRoomProductConditionOption.fromJson(v));
      });
    }
    return list;
  }
}
