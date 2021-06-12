import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:torrpix/models/httpResponse.dart';
import 'package:torrpix/models/torrent.dart';
import 'package:torrpix/models/ytsMovie.dart';


class TorrentAPIHelper {
  static Future<HTTPResponse<List<Torrent>>> getTorrents(
      {required String query} ) async {
    String modifiedQuery = query.replaceAll(RegExp('\\s+'), '%20');
    var uri = Uri.parse('https://yts.torrentbay.to/api/v2/list_movies.json?query_term=$modifiedQuery');
    try {
      var response = await get(
        uri,
      );
      log('$query : $uri');
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Torrent>? torrents = [];
        if(body['data']['movie_count'] > 0){
          body['data']['movies'].forEach((e) {
            YTSMovie ytsMovie = YTSMovie.fromJson(e);
            if(ytsMovie.title == query){
              torrents = ytsMovie.torrents ?? [];
            }
          });
        }
        return HTTPResponse<List<Torrent>>(
          true,
          torrents!,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<Torrent>>(
          false,
          [],
          message:
          'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<Torrent>>(
        false,
        [],
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<Torrent>>(
        false,
        [],
        message:
        'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<Torrent>>(
        false,
        [],
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }
}