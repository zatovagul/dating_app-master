import 'user.dart';
import 'package:flutter/material.dart';

class AllFeedback {
  final int id;
  final int userId;
  final String cityIsoCode;
  final String countryIsoCode;
  final String name;
  final String description;
  final String hashtag;
  final String preview;
  final String title;
  final String socialJson;
  final String language;
  final String createdAt;
  final String updatedAt;
  final int commentsCount;
  final int likesCount;
  final List<dynamic> images;
  final User user;

  factory AllFeedback.fromJson(Map<String, dynamic> json) {
    return AllFeedback(
      id: json['id'],
      userId: json['userId'],
      cityIsoCode: json['cityIsoCode'],
      countryIsoCode: json['countryIsoCode'],
      name: json['name'],
      description: json['description'],
      hashtag: json['hashtag'],
      preview: json['preview'],
      title: json['title'],
      socialJson: json['socialJson'],
      language: json['language'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      commentsCount: json['commentsCount'],
      likesCount: json['likesCount'],
      images: json['images'],
      user: User.fromJson(json['user']),
    );
  }

  static List<AllFeedback> fromJsonList(items) {
    List<AllFeedback> result = [];
    for (var item in items) {
      print('item: $item');
      result.add(AllFeedback.fromJson(item));
    }
    return result;
  }

  AllFeedback({
    @required this.id,
    @required this.userId,
    @required this.cityIsoCode,
    @required this.countryIsoCode,
    @required this.name,
    @required this.description,
    @required this.hashtag,
    @required this.preview,
    @required this.title,
    @required this.socialJson,
    @required this.language,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.commentsCount,
    @required this.likesCount,
    @required this.images,
    @required this.user,
  });
}
