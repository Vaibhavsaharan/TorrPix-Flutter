
import 'package:torrpix/models/torrent.dart';

class YTSMovie {
  YTSMovie({
    required this.id,
    this.url,
    this.imdbCode,
    required this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    //required this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  int id;
  String? url;
  String? imdbCode;
  String title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  //MpaRating mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? state;
  List<Torrent>? torrents;
  DateTime? dateUploaded;
  int? dateUploadedUnix;

  factory YTSMovie.fromJson(Map<String, dynamic> json) => YTSMovie(
    id: json["id"],
    url: json["url"] ?? '',
    imdbCode: json["imdb_code"] ?? '',
    title: json["title"],
    titleEnglish: json["title_english"] ?? '',
    titleLong: json["title_long"] ?? '',
    slug: json["slug"] ?? '',
    year: json["year"] ?? 0,
    rating: json["rating"].toDouble() ?? 0.0,
    runtime: json["runtime"] ?? 0,
    genres: List<String>.from(json["genres"].map((x) => x)),
    summary: json["summary"] ?? '',
    descriptionFull: json["description_full"] ?? '',
    synopsis: json["synopsis"] ?? '',
    ytTrailerCode: json["yt_trailer_code"] ?? '',
    language: json["language"] ?? '',
    //mpaRating: mpaRatingValues.map[json["mpa_rating"]],
    backgroundImage: json["background_image"] ?? '',
    backgroundImageOriginal: json["background_image_original"] ?? '',
    smallCoverImage: json["small_cover_image"] ?? '',
    mediumCoverImage: json["medium_cover_image"] ?? '',
    largeCoverImage: json["large_cover_image"]  ?? '',
    state: json["state"] ?? '',
    torrents: List<Torrent>.from(json["torrents"].map((x) => Torrent.fromJson(x))),
    dateUploaded: DateTime.parse(json["date_uploaded"]),
    dateUploadedUnix: json["date_uploaded_unix"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "imdb_code": imdbCode,
    "title": title,
    "title_english": titleEnglish,
    "title_long": titleLong,
    "slug": slug,
    "year": year,
    "rating": rating,
    "runtime": runtime,
    "genres": List<dynamic>.from(genres!.map((x) => x)),
    "summary": summary,
    "description_full": descriptionFull,
    "synopsis": synopsis,
    "yt_trailer_code": ytTrailerCode,
    "language": language,
    //"mpa_rating": mpaRatingValues.reverse[mpaRating],
    "background_image": backgroundImage,
    "background_image_original": backgroundImageOriginal,
    "small_cover_image": smallCoverImage,
    "medium_cover_image": mediumCoverImage,
    "large_cover_image": largeCoverImage,
    "state": state,
    "torrents": List<dynamic>.from(torrents!.map((x) => x.toJson())),
    "date_uploaded": dateUploaded!.toIso8601String(),
    "date_uploaded_unix": dateUploadedUnix,
  };
}