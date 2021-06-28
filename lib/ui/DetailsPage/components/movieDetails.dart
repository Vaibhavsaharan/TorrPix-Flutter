import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:torrpix/ui/DetailsPage/components/torrentList.dart';
import 'package:torrpix/ui/DetailsPage/components/webTor.dart';

String movieName_global = "";

class MovieDetails extends StatefulWidget {
  final String movieName;
  MovieDetails({required this.movieName});

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  late Future<YtsResults> futureYtsResults;

  @override
  void initState() {
    super.initState();
    movieName_global = widget.movieName;
    log(movieName_global);
    futureYtsResults = fetchYtsResults();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<YtsResults>(
          future: futureYtsResults,
          builder: (context, snapshot) {
          if (snapshot.hasData) {
            YtsResults? ytsData = snapshot.data;
            List<Movie>? moviesList = ytsData!.data.movies;
            return _listMovies(moviesList);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
      },
    ),
    );
  }
}

Future<YtsResults> fetchYtsResults() async {
  final response = await http.get(Uri.parse('https://yts.torrentbay.to/api/v2/list_movies.json?query_term='+movieName_global));
  log('response : ${response.body}');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return YtsResults.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movie detail');
  }
}

ListView _listMovies(data) {

  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        List<Torrent> torrentList = data[index].torrents;
        return Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TorrentList(torrents: torrentList)));
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(child: _tile(data[index].titleLong, data[index].mediumCoverImage, data[index].title)),
                ),
              ),
            ),
          ],
        );
      });
}

ListTile _tile(String title, String posterPath, String overview) => ListTile(
  isThreeLine: false,
  enabled: true,
  title: Text(title,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      )),
  subtitle: Text(overview, maxLines: 3, overflow: TextOverflow.ellipsis),
  leading: ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: 54,
      minHeight: 94,
      maxWidth: 104,
      maxHeight: 174,
    ),
    child: Image.network(posterPath, fit: BoxFit.fitHeight),
  ),
);





YtsResults ytsResultsFromJson(String str) => YtsResults.fromJson(json.decode(str));

String ytsResultsToJson(YtsResults data) => json.encode(data.toJson());

class YtsResults {
  YtsResults({
    required this.status,
    required this.statusMessage,
    required this.data,
    required this.meta,
  });

  String status;
  String statusMessage;
  Data data;
  Meta meta;

  factory YtsResults.fromJson(Map<String, dynamic> json) => YtsResults(
    status: json["status"],
    statusMessage: json["status_message"],
    data: Data.fromJson(json["data"]),
    meta: Meta.fromJson(json["@meta"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_message": statusMessage,
    "data": data.toJson(),
    "@meta": meta.toJson(),
  };
}

class Data {
  Data({
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
    required this.movies,
  });

  int movieCount;
  int limit;
  int pageNumber;
  List<Movie> movies;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    movieCount: json["movie_count"],
    limit: json["limit"],
    pageNumber: json["page_number"],
    movies: List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "movie_count": movieCount,
    "limit": limit,
    "page_number": pageNumber,
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
  };
}

class Movie {
  Movie({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.descriptionFull,
    required this.synopsis,
    required this.ytTrailerCode,
    required this.language,
    //required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.state,
    required this.torrents,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  int id;
  String url;
  String imdbCode;
  String title;
  String titleEnglish;
  String titleLong;
  String slug;
  int year;
  double rating;
  int runtime;
  List<String> genres;
  String summary;
  String descriptionFull;
  String synopsis;
  String ytTrailerCode;
  String language;
  //MpaRating mpaRating;
  String backgroundImage;
  String backgroundImageOriginal;
  String smallCoverImage;
  String mediumCoverImage;
  String largeCoverImage;
  String state;
  List<Torrent> torrents;
  DateTime dateUploaded;
  int dateUploadedUnix;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"],
    url: json["url"],
    imdbCode: json["imdb_code"],
    title: json["title"],
    titleEnglish: json["title_english"],
    titleLong: json["title_long"],
    slug: json["slug"],
    year: json["year"],
    rating: json["rating"].toDouble(),
    runtime: json["runtime"],
    genres: List<String>.from(json["genres"].map((x) => x)),
    summary: json["summary"],
    descriptionFull: json["description_full"],
    synopsis: json["synopsis"],
    ytTrailerCode: json["yt_trailer_code"],
    language: json["language"],
    //mpaRating: mpaRatingValues.map[json["mpa_rating"]],
    backgroundImage: json["background_image"],
    backgroundImageOriginal: json["background_image_original"],
    smallCoverImage: json["small_cover_image"],
    mediumCoverImage: json["medium_cover_image"],
    largeCoverImage: json["large_cover_image"],
    state: json["state"],
    torrents: List<Torrent>.from(json["torrents"].map((x) => Torrent.fromJson(x))),
    dateUploaded: DateTime.parse(json["date_uploaded"]),
    dateUploadedUnix: json["date_uploaded_unix"],
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
    "genres": List<dynamic>.from(genres.map((x) => x)),
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
    "torrents": List<dynamic>.from(torrents.map((x) => x.toJson())),
    "date_uploaded": dateUploaded.toIso8601String(),
    "date_uploaded_unix": dateUploadedUnix,
  };
}

class Torrent {
  Torrent({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  String url;
  String hash;
  String quality;
  String type;
  int seeds;
  int peers;
  String size;
  int sizeBytes;
  DateTime dateUploaded;
  int dateUploadedUnix;

  factory Torrent.fromJson(Map<String, dynamic> json) => Torrent(
    url: json["url"],
    hash: json["hash"],
    quality: json["quality"],
    type: json["type"],
    seeds: json["seeds"],
    peers: json["peers"],
    size: json["size"],
    sizeBytes: json["size_bytes"],
    dateUploaded: DateTime.parse(json["date_uploaded"]),
    dateUploadedUnix: json["date_uploaded_unix"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "hash": hash,
    "quality": quality,
    "type": type,
    "seeds": seeds,
    "peers": peers,
    "size": size,
    "size_bytes": sizeBytes,
    "date_uploaded": dateUploaded.toIso8601String(),
    "date_uploaded_unix": dateUploadedUnix,
  };
}

class Meta {
  Meta({
    required this.serverTime,
    required this.serverTimezone,
    required this.apiVersion,
    required this.executionTime,
  });

  int serverTime;
  String serverTimezone;
  int apiVersion;
  String executionTime;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    serverTime: json["server_time"],
    serverTimezone: json["server_timezone"],
    apiVersion: json["api_version"],
    executionTime: json["execution_time"],
  );

  Map<String, dynamic> toJson() => {
    "server_time": serverTime,
    "server_timezone": serverTimezone,
    "api_version": apiVersion,
    "execution_time": executionTime,
  };
}


