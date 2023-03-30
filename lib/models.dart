import 'dart:convert';

import 'package:intl/intl.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.homeAddress,
    this.password,
  });

  int? id;
  String firstName;
  String lastName;
  String phone;
  String email;
  DateTime birthDate;
  String gender;
  String homeAddress;
  String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        birthDate: DateTime.parse(json["birth_date"]),
        gender: json["gender"],
        homeAddress: json["home_address"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "birth_date": birthDate.toIso8601String(),
        "gender": gender,
        "telegram_nickname": "",
        "home_address": homeAddress,
        "password": password,
      };
}

List<TrustedContactModel> multipleTrustedContactsFromJson(String str) =>
    List<TrustedContactModel>.from(
        json.decode(str).map((x) => TrustedContactModel.fromJson(x)));

TrustedContactModel trustedContactFromJson(String str) =>
    TrustedContactModel.fromJson(json.decode(str));

String trustedContactToJson(TrustedContactModel data) =>
    json.encode(data.toJson());

class TrustedContactModel {
  TrustedContactModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.telegramNickname,
  });

  int? id;
  String name;
  String phone;
  String email;
  String telegramNickname;

  factory TrustedContactModel.fromJson(Map<String, dynamic> json) =>
      TrustedContactModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        telegramNickname: json["telegram_nickname"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "telegram_nickname": telegramNickname,
      };
}

List<SosRequestModel> multipleSosRequestHistoryEntriesFromJson(String str) =>
    List<SosRequestModel>.from(
        json.decode(str).map((x) => SosRequestModel.fromJson(x)));

class SosRequestModel {
  SosRequestModel({
    required this.id,
    required this.userId,
    required this.isActive,
    required this.createdAt,
  });

  int id;
  int userId;
  bool isActive;
  DateTime createdAt;

  factory SosRequestModel.fromJson(Map<String, dynamic> json) =>
      SosRequestModel(
        id: json["id"],
        userId: json["user"]["id"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}

List<ArticleModel> multipleArticlesFromJson(String str) =>
    List<ArticleModel>.from(
        json.decode(str).map((x) => ArticleModel.fromJson(x)));

class ArticleModel {
  static const int contentPreviewCharsCount = 100, titleCropCharsCount = 20;

  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  int id;
  String title;
  String content;
  DateTime createdAt;

  String getCroppedTitle() {
    return title.length <= titleCropCharsCount
        ? title
        : title.substring(0, titleCropCharsCount);
  }

  String previewContent() {
    return '${content.substring(0, contentPreviewCharsCount)}...';
  }

  String pubDate() {
    return '${DateFormat.d().format(createdAt)}/${DateFormat.m().format(createdAt)}/${DateFormat.y().format(createdAt)}';
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
