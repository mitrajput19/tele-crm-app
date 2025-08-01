class GenericResponse<T> {
  String? errorMessage;
  bool? success;
  String? successMessage;
  T? data;

  GenericResponse({
    this.errorMessage,
    this.success,
    this.successMessage,
    this.data,
  });

  GenericResponse.fromJson(Map<String, dynamic> json) {
    errorMessage = json['error_message'] ?? json['message'];
    successMessage = json['success_message'];
    success = json['success'];
    data = json['data'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_message'] = this.errorMessage;
    data['success'] = this.success;
    data['success_msg'] = this.successMessage;
    data['data'] = this.data;
    return data;
  }

  GenericResponse<T> copyWith({
    int? errorCode,
    String? errorMsg,
    int? successCode,
    String? successMsg,
    T? data,
  }) {
    return GenericResponse<T>(
      errorMessage:this.errorMessage,
      success:  this.success,
      successMessage: successMsg ?? this.successMessage,
      data: data ?? this.data,
    );
  }
}
