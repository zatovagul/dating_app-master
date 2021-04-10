import 'package:flutter/material.dart';

class UserLogin {
  //
  final String password, enterField;

  UserLogin({
    @required this.password,
    @required this.enterField,
  });

  UserLogin.fromJson(Map<String, dynamic> json)
      : password = json['password'] as String,
        enterField = json['enterField'] as String;

  Map<String, dynamic> toJson() => {
        'enterField': this.enterField,
        'password': this.password,
      };
//
}
