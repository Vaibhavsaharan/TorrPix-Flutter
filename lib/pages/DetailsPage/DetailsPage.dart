import 'package:flutter/material.dart';
import 'package:torrpix/pages/DetailsPage/components/body.dart';

import '../../constants.dart';

class Details extends StatelessWidget {

  Details({
    required Key key,
    required this.movieName, movie_name,
  }) : super(key: key);
  String movieName ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CONST_PRIMARY_COLOR,
      ),
      body: Body(movieName: movieName),
    );
  }
}
