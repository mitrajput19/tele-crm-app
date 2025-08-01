import 'package:hive/hive.dart';

part 'translation_model.g.dart';

@HiveType(typeId: 0)
class TranslationModelAdaptor extends HiveObject {
  @HiveField(0)
  late int? translationKeywordId;

  @HiveField(1)
  late String? translationKeywordKey;

  @HiveField(2)
  late String? translationKeywordDefaultValue;

  @HiveField(3)
  late int? translationLanguageKeywordMappingId;

  @HiveField(4)
  late int? translationLanguageId;

  @HiveField(5)
  late String? translationValue;

  TranslationModelAdaptor({
    this.translationKeywordId,
    this.translationKeywordKey,
    this.translationKeywordDefaultValue,
    this.translationLanguageKeywordMappingId,
    this.translationLanguageId,
    this.translationValue,
  });

  TranslationModelAdaptor.fromJson(Map<String, dynamic> json) {
    translationKeywordId = json['translation_keyword_id'];
    translationKeywordKey = json['translation_keyword_key'];
    translationKeywordDefaultValue = json['translation_keyword_default_value'];
    translationLanguageKeywordMappingId = json['translation_language_keyword_mapping_id'];
    translationLanguageId = json['translation_language_id'];
    translationValue = json['translation_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['translation_keyword_id'] = this.translationKeywordId;
    data['translation_keyword_key'] = this.translationKeywordKey;
    data['translation_keyword_default_value'] = this.translationKeywordDefaultValue;
    data['translation_language_keyword_mapping_id'] = this.translationLanguageKeywordMappingId;
    data['translation_language_id'] = this.translationLanguageId;
    data['translation_value'] = this.translationValue;
    return data;
  }
}
