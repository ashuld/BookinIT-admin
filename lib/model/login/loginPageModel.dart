// To parse this JSON data, do
//
//     final loginPageModel = loginPageModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

LoginPageModel loginPageModelFromJson(String str) =>
    LoginPageModel.fromJson(json.decode(str));

String loginPageModelToJson(LoginPageModel data) => json.encode(data.toJson());

class LoginPageModel {
  String password;
  String email;

  LoginPageModel({
    required this.password,
    required this.email,
  });

  factory LoginPageModel.fromJson(Map<String, dynamic> json) => LoginPageModel(
        password: json["password"],
        email: json[" email"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        " email": email,
      };
}
