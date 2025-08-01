class ForgotPassword {
  int? employeeId;
  int? forgotPasswordId;
  String? message;

  ForgotPassword({
    this.employeeId,
    this.forgotPasswordId,
    this.message,
  });

  ForgotPassword.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    forgotPasswordId = json['forgot_password_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['forgot_password_id'] = this.forgotPasswordId;
    data['message'] = this.message;
    return data;
  }
}
