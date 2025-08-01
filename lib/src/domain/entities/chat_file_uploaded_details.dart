class ChatFileUploadedDetails {
  String? name;
  String? url;
  String? fileType;
  num? fileSize;

  ChatFileUploadedDetails({
    this.name,
    this.url,
    this.fileType,
    this.fileSize,
  });

  ChatFileUploadedDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    fileType = json['file_type'];
    fileSize = json['file_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['file_type'] = this.fileType;
    data['file_size'] = this.fileSize;
    return data;
  }

  static List<ChatFileUploadedDetails> listFromJson(dynamic json) {
    List<ChatFileUploadedDetails> list = [];
    if (json['uploadedFiles'] != null) {
      json['uploadedFiles'].forEach((v) {
        list.add(new ChatFileUploadedDetails.fromJson(v));
      });
    }
    return list;
  }
}
