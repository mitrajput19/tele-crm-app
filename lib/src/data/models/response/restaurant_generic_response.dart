class RestaurantGenericResponse<T> {
  dynamic errorCode;
  String? message;
  dynamic success;
  T? data;

  RestaurantGenericResponse({
    this.errorCode,
    this.message,
    this.success,
    this.data,
  });

  RestaurantGenericResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    message = json['message'];
    success = json['success'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    data['message'] = this.message;
    data['success'] = this.success;
    data['data'] = this.data;
    return data;
  }

  RestaurantGenericResponse<T> copyWith({
    int? errorCode,
    String? message,
    dynamic success,
    T? data,
  }) {
    return RestaurantGenericResponse<T>(
      errorCode: errorCode ?? this.errorCode,
      message: message ?? this.message,
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }
}
