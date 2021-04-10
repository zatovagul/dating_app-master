import 'package:flutter/material.dart';

class UserRegistration {
  //
  final String password, password_confirmation, enterField;

  UserRegistration({
    @required this.password,
    @required this.password_confirmation,
    @required this.enterField,
  });

  UserRegistration.fromJson(Map<String, dynamic> json)
      : password = json['password'] as String,
        password_confirmation = json['password_confirmation'] as String,
        enterField = json['enterField'] as String;

  Map<String, dynamic> toJson() => {
        'enterField': this.enterField,
        'password': this.password,
        'password_confirmation': this.password_confirmation,
      };
//
}
