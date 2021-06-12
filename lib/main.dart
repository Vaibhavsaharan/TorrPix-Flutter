import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:torrpix/constants.dart';
import 'package:torrpix/pages/HomePage/HomePage.dart';
import 'package:torrpix/providers/homePageProvider.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TorrPix',
      theme: ThemeData(
        scaffoldBackgroundColor: CONST_DEFAULT_BACKGROUND_COLOR,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        primarySwatch: CONST_PRIMARY_COLOR,
      ),
      home: ChangeNotifierProvider<HomePageProvider>(
        create: (context) => HomePageProvider(),
        child: Home(),
      ),
    );
  }
}
