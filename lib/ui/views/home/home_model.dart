import 'dart:convert';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:torrpix/app/app.locator.dart';
import 'package:torrpix/app/app.router.dart';
import 'package:torrpix/models/movie.dart';
import 'package:flutter/services.dart' show rootBundle;


class HomeViewModel extends BaseViewModel{
  final _navigationService = locator<NavigationService>();
  List<Movie> discoverMovie = [];

  init() async{
    var discoverMovieData = json.decode(await getDiscoverMovieJson());

    discoverMovieData['discoverMovie'].forEach((movieData) => {
        discoverMovie.add(Movie.fromJson(movieData))
    });
    print(discoverMovie[0].title);
  }
  Future<String> getDiscoverMovieJson() async {
    return await rootBundle.loadString('assets/data/discover_movie.json');
  }

  goToSearchView (){
    _navigationService.navigateTo(Routes.searchView);
  }

}