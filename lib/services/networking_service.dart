import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:dating_app/models/user_registration.dart';
import 'package:dating_app/models/user_login.dart';
import 'app_endpoints.dart';
import 'authentication_interceptor.dart';
import 'headers_interceptor.dart';
import 'logging_interceptor.dart';

class NetworkingService {
  //
  NetworkingService._();

  static Client httpClient = HttpClientWithInterceptor.build(interceptors: [
    HeadersInterceptor(),
    AuthenticationInterceptor(),
    LoggingInterceptor() /* It must be last */,
  ]);

  static Future<Response> auth(UserLogin data) async {
    try {
      Response response = await httpClient.post(
        AppEndpoints.auth,
        body: json.encode(data.toJson()),
      );
      return response;
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find info");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  static Future<Response> registration(UserRegistration data) async {
    try {
      Response registration = await httpClient.post(
        AppEndpoints.registration,
        body: json.encode(data.toJson()),
      );
      return registration;
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find info");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  static Future<Response> verification(Map<String, String> data) async {
    try {
      Response registration = await httpClient.get(
        AppEndpoints.verification + '?enterField=${data['enterField']}&has=${data['has']}',
      );
      return registration;
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find info");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  static Future<Response> showUsers() async {
    try {
      Response users = await httpClient.get(
        AppEndpoints.users,
      );
      return users;
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find info");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  static Future<Response> refresh(String token) async {
    try {
      Response response = await httpClient.post(
        AppEndpoints.refresh,
        body: json.encode({'refreshToken': token}),
      );
      return response;
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find info");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  static Future<Response> allFeedbacks() async {
    try {
      Response response = await httpClient.get(
        AppEndpoints.allFeedbacks,
      );
      return response;
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find info");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  static Future<Response> startResetPassword(String enterField) async {
    try {
      String body = json.encode({'enterField': enterField});

      Response response = await httpClient.post(
        AppEndpoints.resetPassword,
        body: body,
      );
      /*status: true*/
      return response;
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find info");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  static Future<Response> mySubscribers() async {
    try {
      Response response = await httpClient.post(
        AppEndpoints.mySubscribers,
      );
      return response;
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find info");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  static Future<Response> endResetPassword(String enterField, String code, String password) async {
    try {
      String body = json.encode({
        'enterField': enterField,
        'code': code,
        'password': password,
      });

      Response response = await httpClient.post(
        AppEndpoints.resetPassword,
        body: body,
      );
      /*status: true*/
      return response;
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find info");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  static Future<Response> getUser(String enterField, String code, String password) async {
    try {
      Response response = await httpClient.get(
        AppEndpoints.getUser,
      );
      /*status: true*/
      return response;
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find info");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  //TODO:addAvatar
  static Future<Response> addAvatar(String enterField, String code, String password) async {
    try {
      String body/*= json.encode({
        'enterField': enterField,
        'code': code,
        'password': password,
      })*/
          ;
//"Загрузить аватарку пользователю. Можно загружать только изображения формата jpeg,png,bmp,tiff, размер макс 4096",
      Response response = await httpClient.post(
        AppEndpoints.addAvatar,
        body: body,
      );
      /*status: true*/
      return response;
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find info");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  //
}
