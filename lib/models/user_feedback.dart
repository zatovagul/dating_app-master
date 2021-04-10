import 'package:flutter/cupertino.dart';

class UserFeedback {
//

  final int id;
  final int user_id;
  final String hashtag;
  final String city_iso_code;
  final String country_iso_code;
  final String name;
  final String description;
  final String preview;
  final String title;
  final String social_json;
  final String language;
  final String created_at;
  final String updated_at;

  UserFeedback({
    @required this.id,
    @required this.user_id,
    @required this.city_iso_code,
    @required this.country_iso_code,
    @required this.name,
    @required this.description,
    @required this.preview,
    @required this.title,
    @required this.social_json,
    @required this.language,
    @required this.created_at,
    @required this.updated_at,
    @required this.hashtag,
  });

  UserFeedback.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user_id = json['user_id'],
        city_iso_code = json['city_iso_code'],
        country_iso_code = json['country_iso_code'],
        name = json['name'],
        description = json['description'],
        preview = json['preview'],
        title = json['title'],
        social_json = json['social_json'],
        language = json['language'],
        created_at = json['created_at'],
        updated_at = json['updated_at'],
        hashtag = json['hashtag'];

  static List<UserFeedback> fromJsonList(items) {
    List<UserFeedback> result = [];
    for (var item in items) {
      result.add(UserFeedback.fromJson(item));
    }
    return result;
  }

//
}
