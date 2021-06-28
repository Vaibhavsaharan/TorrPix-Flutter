import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:torrpix/ui/views/home/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery
        .of(context)
        .size;
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) =>
          Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.grey[850],
              child: const Icon(Icons.cast),
              onPressed: model.goToSearchView
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: screenSize.height * 0.6,
                  title: Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('TorrPix'),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            textStyle: TextStyle(fontSize: 24)),
                      )
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/original/db32LaOibwEliAmSL2jjDF6oDdj.jpg',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.black,
                              Colors.transparent
                            ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        )
                    ]),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    child: ListView.builder(itemBuilder: itemBuilder),
                  ),
                )
              ],
            ),
          ),
    );
  }
}
