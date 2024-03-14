// To parse this JSON data, do
//
//     final searchResp = searchRespFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

SearchResp searchRespFromJson(String str) =>
    SearchResp.fromJson(json.decode(str));

String searchRespToJson(SearchResp data) => json.encode(data.toJson());

class SearchResp {
  // bool success;
  // String message;
  List<SearchResult> data;

  SearchResp({
    // required this.success,
    // required this.message,
    required this.data,
  });

  factory SearchResp.fromJson(Map<String, dynamic> json) => SearchResp(
        // success: json["success"],
        // message: json["message"],
        data: List<SearchResult>.from(
            json["results"].map((x) => SearchResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "success": success,
        // "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchResult {
  String? id;
  int? movieId;
  String? originalTitle;
  String? language;
  DateTime releaseDate;
  dynamic image;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  SearchResult({
    required this.id,
    required this.movieId,
    required this.originalTitle,
    required this.language,
    required this.releaseDate,
    required this.image,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        id: json["_id"],
        movieId: json["movieId"],
        originalTitle: json["title"],
        language: json["language"] ?? "en",
        releaseDate: DateTime.parse(json["releaseDate"] ?? "2012-02-27"),
        image: json["image"],
        v: json["__v"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "movieId": movieId,
        "title": originalTitle,
        "language": languageValues.reverse[language],
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "image": image,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

enum Language { EN, ML, JA }

final languageValues =
    EnumValues({"en": Language.EN, "ja": Language.JA, "ml": Language.ML});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
