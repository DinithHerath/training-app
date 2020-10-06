// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diaryData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryEntry _$DiaryEntryFromJson(Map<String, dynamic> json) {
  return DiaryEntry(
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$DiaryEntryToJson(DiaryEntry instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
    };
