import '../../../app/app.dart';

class TaskStepRoomInspectionDetails {
  int? productStockAssignmentId;
  int? productStockId;
  String? productStockAssignmentCode;
  String? productStockAssignmentDate;
  int? productId;
  String? productName;
  String? productBarQrCode;
  String? productStockManufacturingDate;
  String? productStockReceivedDate;
  String? currentProductStockConditionName;
  String? currentProductStockConditionBgColor;
  String? currentProductStockConditionTextColor;
  int? currentProductStockConditionId;
  String? currentProductStockConditionChangeDate;
  String? newProductStockConditionName;
  String? newProductStockConditionBgColor;
  String? newProductStockConditionTextColor;
  int? newProductStockConditionId;
  String? newProductStockConditionChangeDate;
  List<TaskStepRoomAsset>? newAssetsUploaded;

  TaskStepRoomInspectionDetails({
    this.productStockAssignmentId,
    this.productStockId,
    this.productStockAssignmentCode,
    this.productStockAssignmentDate,
    this.productId,
    this.productName,
    this.productBarQrCode,
    this.productStockManufacturingDate,
    this.productStockReceivedDate,
    this.currentProductStockConditionName,
    this.currentProductStockConditionBgColor,
    this.currentProductStockConditionTextColor,
    this.currentProductStockConditionId,
    this.currentProductStockConditionChangeDate,
    this.newProductStockConditionName,
    this.newProductStockConditionBgColor,
    this.newProductStockConditionTextColor,
    this.newProductStockConditionId,
    this.newProductStockConditionChangeDate,
    this.newAssetsUploaded,
  });

  TaskStepRoomInspectionDetails.fromJson(Map<String, dynamic> json) {
    productStockAssignmentId = json['product_stock_assignment_id'];
    productStockId = json['product_stock_id'];
    productStockAssignmentCode = json['product_stock_assignment_code'];
    productStockAssignmentDate = json['product_stock_assignment_date'];
    productId = json['product_id'];
    productName = json['product_name'];
    productBarQrCode = json['product_bar_qr_code'];
    productStockManufacturingDate = json['product_stock_manufacturing_date'];
    productStockReceivedDate = json['product_stock_received_date'];
    currentProductStockConditionName = json['current_product_stock_condition_name'];
    currentProductStockConditionBgColor = json['current_product_stock_condition_bg_color'];
    currentProductStockConditionTextColor = json['current_product_stock_condition_text_color'];
    currentProductStockConditionId = json['current_product_stock_condition_id'];
    currentProductStockConditionChangeDate = json['current_product_stock_condition_change_date'];
    newProductStockConditionName = json['new_product_stock_condition_name'];
    newProductStockConditionBgColor = json['new_product_stock_condition_bg_color'];
    newProductStockConditionTextColor = json['new_product_stock_condition_text_color'];
    newProductStockConditionId = json['new_product_stock_condition_id'];
    newProductStockConditionChangeDate = json['new_product_stock_condition_change_date'];
    if (json['new_assets_uploaded'] != null) {
      newAssetsUploaded = <TaskStepRoomAsset>[];
      json['new_assets_uploaded'].forEach((v) {
        newAssetsUploaded!.add(new TaskStepRoomAsset.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_stock_assignment_id'] = this.productStockAssignmentId;
    data['product_stock_id'] = this.productStockId;
    data['product_stock_assignment_code'] = this.productStockAssignmentCode;
    data['product_stock_assignment_date'] = this.productStockAssignmentDate;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_bar_qr_code'] = this.productBarQrCode;
    data['product_stock_manufacturing_date'] = this.productStockManufacturingDate;
    data['product_stock_received_date'] = this.productStockReceivedDate;
    data['current_product_stock_condition_name'] = this.currentProductStockConditionName;
    data['current_product_stock_condition_bg_color'] = this.currentProductStockConditionBgColor;
    data['current_product_stock_condition_text_color'] = this.currentProductStockConditionTextColor;
    data['current_product_stock_condition_id'] = this.currentProductStockConditionId;
    data['current_product_stock_condition_change_date'] = this.currentProductStockConditionChangeDate;
    data['new_product_stock_condition_name'] = this.newProductStockConditionName;
    data['new_product_stock_condition_bg_color'] = this.newProductStockConditionBgColor;
    data['new_product_stock_condition_text_color'] = this.newProductStockConditionTextColor;
    data['new_product_stock_condition_id'] = this.newProductStockConditionId;
    data['new_product_stock_condition_change_date'] = this.newProductStockConditionChangeDate;
    if (this.newAssetsUploaded != null) {
      data['new_assets_uploaded'] = this.newAssetsUploaded!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<TaskStepRoomInspectionDetails> listFromJson(dynamic json) {
    List<TaskStepRoomInspectionDetails> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new TaskStepRoomInspectionDetails.fromJson(v));
      });
    }
    return list;
  }
}
