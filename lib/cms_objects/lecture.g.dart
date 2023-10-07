// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureContent _$LectureContentFromJson(Map<String, dynamic> json) =>
    LectureContent(
      sys: SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
      fields: Lecture.fromJson(json['fields'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LectureContentToJson(LectureContent instance) =>
    <String, dynamic>{
      'sys': instance.sys,
      'fields': instance.fields,
    };

Lecture _$LectureFromJson(Map<String, dynamic> json) => Lecture(
      json['title'] as String,
      json['views'] as int,
      DateTime.parse(json['dateOfCreation'] as String),
      json['thumbnail'] as Map<String, dynamic>,
      json['content'] as String,
    );

Map<String, dynamic> _$LectureToJson(Lecture instance) => <String, dynamic>{
      'title': instance.title,
      'views': instance.views,
      'dateOfCreation': instance.dateOfCreation.toIso8601String(),
      'thumbnail': instance.thumbnail,
      'content': instance.content,
    };
