import 'dart:developer';

import 'package:torrpix/models/torrent.dart';

// class Movie {
//   Movie({
//     this.id,
//     this.imdbCode,
//     required this.title,
//     this.titleEnglish,
//     this.titleLong,
//     required this.slug,
//     required this.year,
//     required this.rating,
//     required this.runtime,
//     required this.genres,
//     required this.summary,
//     required this.descriptionFull,
//     required this.synopsis,
//     required this.ytTrailerCode,
//     required this.language,
//     //required this.mpaRating,
//     this.backgroundImage,
//     required this.backgroundImageOriginal,
//     required this.smallCoverImage,
//     required this.mediumCoverImage,
//     required this.largeCoverImage,
//     required this.state,
//     required this.torrents,
//     required this.dateUploaded,
//     required this.dateUploadedUnix,
//   });
//
//   int? id;
//   String? url;
//   String? imdbCode;
//   String title;
//   String? titleEnglish;
//   String? titleLong;
//   String? slug;
//   int? year;
//   double? rating;
//   int? runtime;
//   List<String>? genres;
//   String? summary;
//   String? descriptionFull;
//   String? synopsis;
//   String? ytTrailerCode;
//   String? language;
//   //MpaRating mpaRating;
//   String? backgroundImage;
//   String? backgroundImageOriginal;
//   String? smallCoverImage;
//   String? mediumCoverImage;
//   String? largeCoverImage;
//   String? state;
//   List<Torrent>? torrents;
//   DateTime dateUploaded;
//   int? dateUploadedUnix;
//
//   factory Movie.fromJson(Map<String, dynamic> json) => Movie(
//     id: json["id"],
//     url: json["url"],
//     imdbCode: json["imdb_code"],
//     title: json["title"],
//     titleEnglish: json["title_english"],
//     titleLong: json["title_long"],
//     slug: json["slug"],
//     year: json["year"],
//     rating: json["rating"].toDouble(),
//     runtime: json["runtime"],
//     genres: List<String>.from(json["genres"].map((x) => x)),
//     summary: json["summary"],
//     descriptionFull: json["description_full"],
//     synopsis: json["synopsis"],
//     ytTrailerCode: json["yt_trailer_code"],
//     language: json["language"],
//     //mpaRating: mpaRatingValues.map[json["mpa_rating"]],
//     backgroundImage: json["background_image"],
//     backgroundImageOriginal: json["background_image_original"],
//     smallCoverImage: json["small_cover_image"],
//     mediumCoverImage: json["medium_cover_image"],
//     largeCoverImage: json["large_cover_image"],
//     state: json["state"],
//     torrents: List<Torrent>.from(json["torrents"].map((x) => Torrent.fromJson(x))),
//     dateUploaded: DateTime.parse(json["date_uploaded"]),
//     dateUploadedUnix: json["date_uploaded_unix"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "url": url,
//     "imdb_code": imdbCode,
//     "title": title,
//     "title_english": titleEnglish,
//     "title_long": titleLong,
//     "slug": slug,
//     "year": year,
//     "rating": rating,
//     "runtime": runtime,
//     "genres": List<dynamic>.from(genres!.map((x) => x)),
//     "summary": summary,
//     "description_full": descriptionFull,
//     "synopsis": synopsis,
//     "yt_trailer_code": ytTrailerCode,
//     "language": language,
//     //"mpa_rating": mpaRatingValues.reverse[mpaRating],
//     "background_image": backgroundImage,
//     "background_image_original": backgroundImageOriginal,
//     "small_cover_image": smallCoverImage,
//     "medium_cover_image": mediumCoverImage,
//     "large_cover_image": largeCoverImage,
//     "state": state,
//     "torrents": List<dynamic>.from(torrents!.map((x) => x.toJson())),
//     "date_uploaded": dateUploaded.toIso8601String(),
//     "date_uploaded_unix": dateUploadedUnix,
//   };
// }
class Movie {
  Movie({
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.torrents,
    required this.isExpanded,
  });


  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  List<Torrent>? torrents;
  bool isExpanded;

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      id: json["id"] ?? 0,
      originalLanguage: json["original_language"] ?? '',
      originalTitle: json["original_title"] ?? '',
      overview: json["overview"] ?? '',
      posterPath: json["poster_path"] ?? '',
      releaseDate: json["release_date"] ?? '',
      title: json["title"] ?? '',
      torrents: [],
      isExpanded: false,
    );
  }

  set setTorrents (List<Torrent> torrentList){
    this.torrents = torrentList;
  }

  List<Torrent> get torrentsList => this.torrents ?? [];

  bool get getIsExpanded => this.isExpanded;

  set toggleIsExpanded(value) => this.isExpanded = value;

  Map<String, dynamic> toJson() => {
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "title": title,
    "torrents" : torrents,
    "isExpanded" : isExpanded
  };
}