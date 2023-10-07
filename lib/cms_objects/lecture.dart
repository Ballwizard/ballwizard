import 'package:flutter_contentful/contentful.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lecture.g.dart';

@JsonSerializable()
class LectureContent extends Entry<Lecture> {
  LectureContent({
    required SystemFields sys,
    required Lecture fields,
  }) : super(sys: sys, fields: fields);

  static LectureContent fromJson(Map<String, dynamic> json) {
    return _$LectureContentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LectureContentToJson(this);
}

@JsonSerializable()
class Lecture {
  final String title;
  final int views;
  final DateTime dateOfCreation;
  final Map<String, dynamic> thumbnail;
  final String content;

  Lecture(this.title, this.views, this.dateOfCreation, this.thumbnail,
      this.content);

  static fromJson(Map<String, dynamic> json) {
    return _$LectureFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LectureToJson(this);
}

class Repository {
  Client contentful = Client(
    BearerTokenHTTPClient(
      'LiOD0kCz-CecODuMpp0AjaRrXUfjX6SudR7XqHoCZw8',
    ),
    spaceId: '91dfqaqpv4yn',
  );

  Future<List<LectureContent>> getProducts() async {
    final collection = await contentful.getEntries<LectureContent>(
      {'content_type': 'lecturePost'},
      LectureContent.fromJson,
    );

    return collection.items;
  }
}
