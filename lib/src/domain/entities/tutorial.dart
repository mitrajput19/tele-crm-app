class TutorialDetails {
  int? currentPage;
  List<Tutorial>? tutorial;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<TutorialLinks>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  TutorialDetails({
    this.currentPage,
    this.tutorial,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  TutorialDetails.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      tutorial = <Tutorial>[];
      json['data'].forEach((v) {
        tutorial!.add(new Tutorial.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <TutorialLinks>[];
      json['links'].forEach((v) {
        links!.add(new TutorialLinks.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.tutorial != null) {
      data['data'] = this.tutorial!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Tutorial {
  int? tutorialId;
  String? tutorialTitle;
  int? translationLanguageId;
  String? tutorialPreviewImageUrl;
  String? tutorialDescription;
  String? tutorialVideoDemoUrl;
  int? tutorialStatus;
  String? createdAt;
  String? updatedAt;

  Tutorial({
    this.tutorialId,
    this.tutorialTitle,
    this.translationLanguageId,
    this.tutorialPreviewImageUrl,
    this.tutorialDescription,
    this.tutorialVideoDemoUrl,
    this.tutorialStatus,
    this.createdAt,
    this.updatedAt,
  });

  Tutorial.fromJson(Map<String, dynamic> json) {
    tutorialId = json['tutorial_id'];
    tutorialTitle = json['tutorial_title'];
    translationLanguageId = json['translation_language_id'];
    tutorialPreviewImageUrl = json['tutorial_preview_image_url'];
    tutorialDescription = json['tutorial_description'];
    tutorialVideoDemoUrl = json['tutorial_video_demo_url'];
    tutorialStatus = json['tutorial_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tutorial_id'] = this.tutorialId;
    data['tutorial_title'] = this.tutorialTitle;
    data['translation_language_id'] = this.translationLanguageId;
    data['tutorial_preview_image_url'] = this.tutorialPreviewImageUrl;
    data['tutorial_description'] = this.tutorialDescription;
    data['tutorial_video_demo_url'] = this.tutorialVideoDemoUrl;
    data['tutorial_status'] = this.tutorialStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TutorialLinks {
  String? url;
  String? label;
  bool? active;

  TutorialLinks({
    this.url,
    this.label,
    this.active,
  });

  TutorialLinks.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
