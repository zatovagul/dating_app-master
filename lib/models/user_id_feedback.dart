import 'package:flutter/cupertino.dart';

class UserIDFeedback {
//

  final int id;
  final int user_id;
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
  final int comments_count;
  final int likes_count;

  UserIDFeedback({
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
    @required this.comments_count,
    @required this.likes_count,
  });

  UserIDFeedback.fromJson(Map<String, dynamic> json)
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
        comments_count = json['comments_count'],
        likes_count = json['likes_count'];

  static List<UserIDFeedback> fromJsonList(items) {
    List<UserIDFeedback> result = [];
    for (var item in items) {
      result.add(UserIDFeedback.fromJson(item));
    }
    return result;
  }

//
}
