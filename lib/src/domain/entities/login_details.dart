class LoginDetails {
  String? hotelCode;
  String? email;
  String? password;

  LoginDetails({this.hotelCode, this.email, this.password});

  LoginDetails.fromJson(Map<String, dynamic> json) {
    hotelCode = json['hotelCode'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotelCode'] = this.hotelCode;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
