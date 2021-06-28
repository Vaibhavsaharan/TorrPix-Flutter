// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:torrpix/constants.dart';
// import 'package:torrpix/models/movie.dart';
// import 'dart:developer';
// import 'package:torrpix/providers/homePageProvider.dart';
// import 'package:torrpix/ui/DetailsPage/DetailsPage.dart';
// import 'package:torrpix/services/searchQuery.dart';
// import 'package:torrpix/services/searchTorrent.dart';
//
//
//
// class HeaderWithSearchBox extends StatefulWidget {
//   const HeaderWithSearchBox({
//     required Key key,
//     required this.size,
//   }) : super(key: key);
//
//   final Size size;
//
//   @override
//   _HeaderWithSearchBoxState createState() => _HeaderWithSearchBoxState();
// }
//
// class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
//   String query = "";
//   var isVisible = true;
//
//   _getMovies({bool refresh = true}) async {
//     var provider = Provider.of<HomePageProvider>(context, listen: false);
//     var moviesResponse = await MovieAPIHelper.getMovies(
//       query: provider.searchQuery,
//       page: 1,
//     );
//     if (moviesResponse.isSuccessful) {
//       if (moviesResponse.data.isNotEmpty) {
//         provider.setMoviesList(moviesResponse.data);
//         var movies = provider.moviesList;
//         for(var i = 0; i < movies!.length; i++){
//           _getTorrents(movies[i].originalTitle ?? '', movies[i].releaseDate ?? '', i);
//         }
//       } else {
//         provider.setShouldRefresh(false);
//       }
//     }
//
//   }
//   _getTorrents(String movieName, String releaseDate, int index) async{
//     var provider = Provider.of<HomePageProvider>(context, listen: false);
//     var torrentsResponse = await TorrentAPIHelper.getTorrents(
//       query: movieName,
//     );
//     if (torrentsResponse.isSuccessful) {
//       if (torrentsResponse.data.isNotEmpty) {
//         var movie = provider.moviesList![index];
//         movie.setTorrents = torrentsResponse.data;
//       } else {
//         provider.setShouldRefresh(false);
//       }
//     }
//   }
//
//
//   void _updateQuery(_query){
//     if(_query == "") return;
//     Provider.of<HomePageProvider>(context, listen:false).setSearchQuery(_query);
//     _getMovies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           margin: EdgeInsets.only(bottom: CONST_DEFAULT_PADDING * 2.5),
//           // It will cover 20% of our total height
//           height: widget.size.height * 0.2,
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.only(
//                   left: CONST_DEFAULT_PADDING,
//                   right: CONST_DEFAULT_PADDING,
//                   bottom: 36 + CONST_DEFAULT_PADDING,
//                 ),
//                 height: widget.size.height * 0.2 - 27,
//                 decoration: BoxDecoration(
//                   color: CONST_PRIMARY_COLOR,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(36),
//                     bottomRight: Radius.circular(36),
//                   ),
//                 ),
//                 child: Row(
//                   children: <Widget>[
//                     Text(
//                       'Hi Vaibhav!',
//                       style: Theme.of(context).textTheme.headline5!.copyWith(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     Spacer(),
//                     IconButton(iconSize: 55,onPressed: (){}, icon: Icon(Icons.account_circle_outlined))
//                   ],
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   alignment: Alignment.center,
//                   margin: EdgeInsets.symmetric(horizontal: CONST_DEFAULT_PADDING),
//                   padding: EdgeInsets.symmetric(horizontal: CONST_DEFAULT_PADDING),
//                   height: 54,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         offset: Offset(0, 10),
//                         blurRadius: 50,
//                         color: CONST_PRIMARY_COLOR.withOpacity(0.23),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: TextField(
//                           onChanged: (String value) {
//                             _updateQuery(value);
//                           },
//                           style: TextStyle(color: Colors.black),
//                           decoration: InputDecoration(
//                             hintText: "Search",
//                             hintStyle: TextStyle(
//                               color: Colors.black.withOpacity(0.5),
//                             ),
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       IconButton(onPressed: (){
//                         var value = this.query;
//                         log('searched : $value');
//                       }, icon: Icon(CupertinoIcons.search)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: CONST_DEFAULT_PADDING),
//         // Visibility(
//         //   visible: this.isVisible,
//         //     child: SingleChildScrollView(child: SearchQuery(key: Key('1'), query: this.query))
//         // ),
//       ],
//     );
//   }
// }
//
//
// class Result {
//   Result({
//     required this.adult,
//     this.backdropPath,
//     required this.id,
//     required this.originalLanguage,
//     required this.originalTitle,
//     required this.overview,
//     this.popularity,
//     this.posterPath,
//     this.releaseDate,
//     required this.title,
//     required this.video,
//     this.voteAverage,
//     this.voteCount,
//   });
//
//   bool adult;
//   String? backdropPath;
//   int id;
//   String originalLanguage;
//   String originalTitle;
//   String overview;
//   double? popularity;
//   String? posterPath;
//   String? releaseDate;
//   String title;
//   bool video;
//   double? voteAverage;
//   int? voteCount;
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     adult: json["adult"],
//     backdropPath: json["backdrop_path"],
//     id: json["id"],
//     originalLanguage: json["original_language"],
//     originalTitle: json["original_title"],
//     overview: json["overview"],
//     popularity: json["popularity"].toDouble(),
//     posterPath: json["poster_path"],
//     releaseDate: json["release_date"],
//     title: json["title"],
//     video: json["video"],
//     voteAverage: json["vote_average"].toDouble(),
//     voteCount: json["vote_count"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "adult": adult,
//     "backdrop_path": backdropPath,
//     "id": id,
//     "original_language": originalLanguage,
//     "original_title": originalTitle,
//     "overview": overview,
//     "popularity": popularity,
//     "poster_path": posterPath,
//     "release_date": releaseDate,
//     "title": title,
//     "video": video,
//     "vote_average": voteAverage,
//     "vote_count": voteCount,
//   };
// }
//
//
// class SearchQuery extends StatelessWidget {
//   final String query ;
//   const SearchQuery({
//     required this.query,
//     required Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Result>>(
//       future: _fetchResults(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<Result>? data = snapshot.data;
//           return _resultsListView(data);
//         } else if (snapshot.hasError) {
//           log('got error');
//           return Text("${snapshot.error}");
//         }
//         return CircularProgressIndicator();
//       },
//     );
//   }
//
//   Future<List<Result>> _fetchResults() async {
//     String modifiedQuery = query.replaceAll(RegExp('\\s+'), '%20');
//     if(query == ""){
//
//     }
//     final moviesAPIUrl = 'https://api.themoviedb.org/3/search/movie?api_key=695abe44625871b0e69ebda85a48ba61&language=en-US&query='+modifiedQuery+'&page=1&include_adult=false';
//     final response = await http.get(Uri.parse(moviesAPIUrl));
//     log('Url : $moviesAPIUrl');
//     if (response.statusCode == 200) {
//       var parsed = jsonDecode(response.body)['results'].cast<Map<String, dynamic>>();
//       return parsed.map<Result>((json) => Result.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load movies from API');
//     }
//   }
//
// // A function that converts a response body into a List<Photo>.
//
//
//   ListView _resultsListView(data) {
//
//     return ListView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: data.length,
//         itemBuilder: (context, index) {
//           var poster;
//           if(data[index].posterPath == null){
//             poster = 'https://cdn4.iconfinder.com/data/icons/planner-color/64/popcorn-movie-time-512.png';
//           }else poster = 'https://image.tmdb.org/t/p/original' + data[index].posterPath;
//           var releaseYear;
//           if(data[index].releaseDate == "" || data[index].releaseDate == null)
//             releaseYear = "N.A.";
//           else releaseYear = data[index].releaseDate.substring(0,4);
//           return Column(
//             children: [
//               GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Details(key: Key('date'), movieName: data[index].title,)));
//                 },
//                 child: Container(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: _tile(data[index].originalTitle+" ("+releaseYear+")", poster , data[index].overview),
//                   ),
//                 ),
//               ),
//               Divider(),
//             ],
//           );
//
//         });
//   }
//
//   ListTile _tile(String title, String posterPath, String overview) => ListTile(
//     isThreeLine: false,
//     enabled: true,
//     title: Text(title,
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.w500,
//           fontSize: 20,
//         )),
//     subtitle: Text(overview, maxLines: 3, overflow: TextOverflow.ellipsis),
//     leading: ConstrainedBox(
//       constraints: BoxConstraints(
//         minWidth: 64,
//         minHeight: 44,
//         maxWidth: 64,
//         maxHeight: 104,
//       ),
//       child: Image.network(posterPath, fit: BoxFit.fitHeight),
//     ),
//   );
// }
//
//
