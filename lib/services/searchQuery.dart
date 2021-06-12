import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:torrpix/models/httpResponse.dart';
import 'package:torrpix/models/movie.dart';


class MovieAPIHelper {
  static Future<HTTPResponse<List<Movie>>> getMovies(
      {int page = 1, required String query} ) async {
    String modifiedQuery = query.replaceAll(RegExp('\\s+'), '%20');
    var uri = Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=695abe44625871b0e69ebda85a48ba61&language=en-US&query=$modifiedQuery&page=$page&include_adult=false');
    try {
      var response = await get(
        uri,
      );
      log('$query : $uri');
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Movie>? movies = [];
        body['results'].forEach((e) {
          Movie movie = Movie.fromJson(e);
          movies.add(movie);
        });
        return HTTPResponse<List<Movie>>(
          true,
          movies,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<Movie>>(
          false,
          [],
          message:
          'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<Movie>>(
        false,
        [],
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<Movie>>(
        false,
        [],
        message:
        'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<Movie>>(
        false,
        [],
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }
}