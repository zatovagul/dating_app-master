import 'package:flutter/cupertino.dart';
import 'user_id_feedback.dart';

class UserID {
//

  final int id;
  final String city_iso_code;
  final String country_iso_code;
  final String email;
  final String login;
  final String avatar_url;
  final String email_verified_at;
  final String created_at; //"2021-01-30T08:22:59.000000Z"
  final String phone_verified_at;
  final int feedbacks_count;
  final int my_subscribers_count;
  final int subscribers_count;
  final List<UserIDFeedback> feedbacks;

  UserID({
    @required this.id,
    @required this.city_iso_code,
    @required this.country_iso_code,
    @required this.email,
    @required this.login,
    @required this.avatar_url,
    @required this.email_verified_at,
    @required this.created_at,
    @required this.phone_verified_at,
    @required this.feedbacks_count,
    @required this.my_subscribers_count,
    @required this.subscribers_count,
    @required this.feedbacks,
  });

  UserID.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        city_iso_code = json['city_iso_code'],
        country_iso_code = json['country_iso_code'],
        email = json['email'],
        login = json['login'],
        avatar_url = json['avatar_url'],
        email_verified_at = json['email_verified_at'],
        created_at = json['created_at'],
        phone_verified_at = json['phone_verified_at'],
        feedbacks_count = json['feedbacks_count'],
        my_subscribers_count = json['my_subscribers_count'],
        subscribers_count = json['subscribers_count'],
        feedbacks = json['feedbacks'];

//
}
