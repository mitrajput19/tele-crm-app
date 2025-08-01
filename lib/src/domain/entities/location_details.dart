class LocationDetails {
  double? longitude;
  double? latitude;

  LocationDetails({
    this.longitude,
    this.latitude,
  });

  LocationDetails.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
