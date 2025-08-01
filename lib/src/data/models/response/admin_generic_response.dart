class AdminGenericResponse<T> {
  int? status;
  int? error;
  String? message;
  T? data;

  AdminGenericResponse({
    this.status,
    this.error,
    this.message,
    this.data,
  });

  AdminGenericResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }

  AdminGenericResponse<T> copyWith({
    int? status,
    int? error,
    String? message,
    T? data,
  }) {
    return AdminGenericResponse<T>(
      status: status ?? this.status,
      error: error ?? this.error,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
