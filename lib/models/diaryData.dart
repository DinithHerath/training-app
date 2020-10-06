import 'package:json_annotation/json_annotation.dart';

part 'diaryData.g.dart';

@JsonSerializable(nullable: false)
class DiaryEntry {
  String title;
  String subtitle;
  String description;

  DiaryEntry({this.title, this.subtitle, this.description});

  factory DiaryEntry.fromJson(Map<String, dynamic> json) => _$DiaryEntryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryEntryToJson(this);
}
