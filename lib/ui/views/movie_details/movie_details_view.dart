import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:torrpix/ui/views/home/home_model.dart';
import 'movie_details_model.dart';
import 'package:chewie/chewie.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<MovieDetailModel>.reactive(
      viewModelBuilder: () => MovieDetailModel(),
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) => Scaffold(

      )
    );
  }
}
