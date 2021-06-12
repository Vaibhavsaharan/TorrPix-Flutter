import 'package:flutter/material.dart';


import 'movieDetails.dart';

class Body extends StatelessWidget {
  final String movieName;
  Body({required this.movieName});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: MovieDetails(movieName : movieName),
    );
  }
}
