import 'package:flutter/material.dart';

import 'user_feedback.dart';

class User {
//

/*  "id": 1,
            "city_iso_code": "RU-YAR",
            "country_iso_code": "RU",
            "last_name": null,
            "first_name": null,
            "public_email": null,
            "login": null,
            "about_me": null,
            "avatar_url": "storage\/\/images\/\/1\/\/avatar\/FS3lNXLKfpdZS2mSTpkEYSsr9RcBli4RM5i3D4XS.jpg",
            "email_verified_at": null,
            "created_at": "2021-01-30T08:22:59.000000Z",
            "phone_verified_at": null*/
  final int id;
  final String city_iso_code;
  final String country_iso_code;
  final String last_name;
  final String first_name;
  final String public_email;
  final String login;
  final String about_me; //"2021-01-30T08:22:59.000000Z"
  final String avatar_url;
  final String created_at;
  final String phone_verified_at;
  final String email_verified_at;

  ///
  ///
  ///
  final int subscribers_count;
  final int my_subscribers_count;
  final List<UserFeedback> feedbacks;

  User({
    @required this.id,
    @required this.city_iso_code,
    @required this.country_iso_code,
    @required this.last_name,
    @required this.first_name,
    @required this.public_email,
    @required this.login,
    @required this.about_me,
    @required this.avatar_url,
    @required this.created_at,
    @required this.phone_verified_at,
    @required this.email_verified_at,
    @required this.subscribers_count,
    @required this.my_subscribers_count,
    @required this.feedbacks,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return new User(
      id: map['id'] as int,
      city_iso_code: map['city_iso_code'] as String,
      country_iso_code: map['country_iso_code'] as String,
      last_name: map['last_name'] as String,
      first_name: map['first_name'] as String,
      public_email: map['public_email'] as String,
      login: map['login'] as String,
      about_me: map['about_me'] as String,
      avatar_url: map['avatar_url'] as String,
      created_at: map['created_at'] as String,
      phone_verified_at: map['phone_verified_at'] as String,
      subscribers_count: map['subscribers_count'],
      my_subscribers_count: map['my_subscribers_count'],
      feedbacks: map['feedbacks'],
      email_verified_at: map['email_verified_at'] as String,
    );
  }

//
}
