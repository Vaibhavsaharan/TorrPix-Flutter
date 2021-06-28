import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:torrpix/ui/views/search/search_view_model.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          body: Center(
            child: Text('Search'),
          ),
        ),
        viewModelBuilder: () => SearchViewModel());
  }
}
