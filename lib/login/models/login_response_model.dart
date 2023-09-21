import 'dart:convert';

import 'package:adecco_ahmad_test/login/models/user_model.dart';

class LoginResponseModel {
  LoginResponseModel({
    required this.status,
    required this.user,
    required this.message,
    required this.token,
  });

  bool? status;
  String? message;
  UserModel? user;
  String? token;

  factory LoginResponseModel.fromRawJson(String str) =>
      LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["ok"],
        user: UserModel.fromJson(json["user"]),
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "ok": status,
        "user": user?.toJson(),
        "token": token,
        "message": message,
      };
}
