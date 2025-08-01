// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranslationModelAdaptorAdapter extends TypeAdapter<TranslationModelAdaptor> {
  @override
  final int typeId = 0;

  @override
  TranslationModelAdaptor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranslationModelAdaptor(
      translationKeywordId: fields[0] as int?,
      translationKeywordKey: fields[1] as String?,
      translationKeywordDefaultValue: fields[2] as String?,
      translationLanguageKeywordMappingId: fields[3] as int?,
      translationLanguageId: fields[4] as int?,
      translationValue: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TranslationModelAdaptor obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.translationKeywordId)
      ..writeByte(1)
      ..write(obj.translationKeywordKey)
      ..writeByte(2)
      ..write(obj.translationKeywordDefaultValue)
      ..writeByte(3)
      ..write(obj.translationLanguageKeywordMappingId)
      ..writeByte(4)
      ..write(obj.translationLanguageId)
      ..writeByte(5)
      ..write(obj.translationValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslationModelAdaptorAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
