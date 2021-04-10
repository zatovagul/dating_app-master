import 'user.dart';
import 'package:flutter/material.dart';

class Subscriber {
//

  int id;
  int userId;
  int subUserId;
  Null createdAt;
  Null updatedAt;
  User subUser;

  Subscriber({
    @required this.id,
    @required this.userId,
    @required this.subUserId,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.subUser,
  });

  Subscriber.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subUserId = json['sub_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subUser = json['sub_user'] != null ? new User.fromJson(json['sub_user']) : null;
  }

//
}
