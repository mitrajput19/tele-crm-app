class UnavailabilityDetails {
  int? employeeUnavailableId;
  int? employeeId;
  String? employeeUnavailableDate;
  int? employeeUnavailableTypeId;
  String? employeeUnavailableTypeName;
  String? employeeUnavailableTypeTextColor;
  String? employeeUnavailableTypeBgColor;

  UnavailabilityDetails({
    this.employeeUnavailableId,
    this.employeeId,
    this.employeeUnavailableDate,
    this.employeeUnavailableTypeId,
    this.employeeUnavailableTypeName,
    this.employeeUnavailableTypeTextColor,
    this.employeeUnavailableTypeBgColor,
  });

  UnavailabilityDetails.fromJson(Map<String, dynamic> json) {
    employeeUnavailableId = json['employee_unavailable_id'];
    employeeId = json['employee_id'];
    employeeUnavailableDate = json['employee_unavailable_date'];
    employeeUnavailableTypeId = json['employee_unavailable_type_id'];
    employeeUnavailableTypeName = json['employee_unavailable_type_name'];
    employeeUnavailableTypeTextColor = json['employee_unavailable_type_text_color'];
    employeeUnavailableTypeBgColor = json['employee_unavailable_type_bg_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_unavailable_id'] = this.employeeUnavailableId;
    data['employee_id'] = this.employeeId;
    data['employee_unavailable_date'] = this.employeeUnavailableDate;
    data['employee_unavailable_type_id'] = this.employeeUnavailableTypeId;
    data['employee_unavailable_type_name'] = this.employeeUnavailableTypeName;
    data['employee_unavailable_type_text_color'] = this.employeeUnavailableTypeTextColor;
    data['employee_unavailable_type_bg_color'] = this.employeeUnavailableTypeBgColor;
    return data;
  }

  static List<UnavailabilityDetails> listFromJson(dynamic json) {
    List<UnavailabilityDetails> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new UnavailabilityDetails.fromJson(v));
      });
    }
    return list;
  }
}
