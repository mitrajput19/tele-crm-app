class MakeRequestGuest {
  int? guestAccountId;
  String? guestName;

  MakeRequestGuest({
    this.guestAccountId,
    this.guestName,
  });

  MakeRequestGuest.fromJson(Map<String, dynamic> json) {
    guestAccountId = json['guest_account_id'];
    guestName = json['guest_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guest_account_id'] = this.guestAccountId;
    data['guest_name'] = this.guestName;
    return data;
  }

  static List<MakeRequestGuest> listFromJson(dynamic json) {
    List<MakeRequestGuest> list = [];
    if (json['details']['guests'] != null) {
      json['details']['guests'].forEach((v) {
        list.add(MakeRequestGuest.fromJson(v));
      });
    }
    return list;
  }
}
