import 'package:flutter/foundation.dart';
import 'package:torrpix/models/movie.dart';


class HomePageProvider extends ChangeNotifier {
  bool _isHomePageProcessing = false;
  int _currentPage = 1;
  List<Movie>? _moviesList = [];
  bool _shouldRefresh = true;
  String _query = '';

  String get searchQuery => _query;

  setSearchQuery(String query) => _query = query;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;

  int get currentPage => _currentPage;

  setCurrentPage(int page) {
    _currentPage = page;
  }

  bool get isHomePageProcessing => _isHomePageProcessing;

  setIsHomePageProcessing(bool value) {
    _isHomePageProcessing = value;
    notifyListeners();
  }

  List<Movie>? get moviesList => _moviesList;

  setMoviesList(List<Movie> list) {
    _moviesList = list;
    notifyListeners();
  }


  Movie getMovieByIndex(int index) => _moviesList![index];

  int get moviesListLength => _moviesList!.length;
}