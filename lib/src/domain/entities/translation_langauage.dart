class TranslationLanguage {
  int? translationLanguageId;
  String? translationLanguageName;
  String? translationLanguageEnglishName;
  String? translationLanguageShortForm;
  String? translationLanguageCode;
  String? translationLanguageTextDirection;
  String? translationLanguageFlag;

  TranslationLanguage({
    this.translationLanguageId,
    this.translationLanguageName,
    this.translationLanguageEnglishName,
    this.translationLanguageShortForm,
    this.translationLanguageCode,
    this.translationLanguageTextDirection,
    this.translationLanguageFlag,
  });

  TranslationLanguage.fromJson(Map<String, dynamic> json) {
    translationLanguageId = json['translation_language_id'];
    translationLanguageName = json['translation_language_name'];
    translationLanguageEnglishName = json['translation_language_english_name'];
    translationLanguageShortForm = json['translation_language_short_form'];
    translationLanguageCode = json['translation_language_code'];
    translationLanguageTextDirection = json['translation_language_text_direction'];
    translationLanguageFlag = json['translation_language_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['translation_language_id'] = this.translationLanguageId;
    data['translation_language_name'] = this.translationLanguageName;
    data['translation_language_english_name'] = this.translationLanguageEnglishName;
    data['translation_language_short_form'] = this.translationLanguageShortForm;
    data['translation_language_code'] = this.translationLanguageCode;
    data['translation_language_text_direction'] = this.translationLanguageTextDirection;
    data['translation_language_flag'] = this.translationLanguageFlag;
    return data;
  }

  static List<TranslationLanguage> listFromJson(dynamic json) {
    List<TranslationLanguage> list = [];
    if (json['data']['translation_language_master'] != null) {
      json['data']['translation_language_master'].forEach((v) {
        list.add(new TranslationLanguage.fromJson(v));
      });
    }
    return list;
  }
}
