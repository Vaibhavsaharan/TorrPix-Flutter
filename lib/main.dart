import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:torrpix/constants.dart';
import 'package:torrpix/ui/HomePage/HomePage.dart';
import 'package:torrpix/ui/views/home/home_view.dart';
import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'constants.dart';


void main() {
  setupLocator();
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
        primaryColor: Colors.black,
      ),
      home: HomeView(),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
