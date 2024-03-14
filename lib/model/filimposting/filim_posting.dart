// To parse this JSON data, do
//
//     final searchDetails = searchDetailsFromJson(jsonString);

import 'dart:convert';

MovieDetails searchDetailsFromJson(String str) => MovieDetails.fromJson(json.decode(str));

String searchDetailsToJson(MovieDetails data) => json.encode(data.toJson());
class SearchResponse {
    // bool success;
    // String message;
    List<MovieDetails> datas;

    SearchResponse({
        // required this.success,
        // required this.message,
        required this.datas,
    });

    factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        // success: json["success"],
        // message: json["message"],
        datas: List<MovieDetails>.from(json["results"].map((x) => MovieDetails.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        // "success": success,
        // "message": message,
        "data": List<dynamic>.from(datas.map((x) => x.toJson())),
    };
}

class MovieDetails {
    bool adult;
    dynamic backdropPath;
    List<int> genreIds;
    int id;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    dynamic posterPath;
    String releaseDate;
    String title;
    bool video;
    dynamic voteAverage;
    dynamic voteCount;

    MovieDetails({
        required this.adult,
        this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        this.posterPath,
        required this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}
