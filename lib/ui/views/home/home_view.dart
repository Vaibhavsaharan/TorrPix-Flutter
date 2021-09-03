import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:torrpix/ui/views/home/home_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey[850],
            child: const Icon(Icons.cast),
            onPressed: model.goToSearchView),
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
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/original/db32LaOibwEliAmSL2jjDF6oDdj.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                Text('My List',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                            Container(
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.play_arrow_rounded,
                                    size: 26,
                                    color: Colors.black,
                                  ),
                                  Text('Play',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                Text('info',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 50,),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  child: Text('Discover Movies', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),),
                ),
              ),
            ),
            SliverToBoxAdapter(child: Divider(indent: 12, endIndent: 12, color: Colors.white,),),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Container(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: model.discoverMovie.length,
                      itemBuilder: (builder, index) {
                        String imgUrl = 'https://image.tmdb.org/t/p/original' +
                            (model.discoverMovie[index].posterPath ?? '');
                        print(model.discoverMovie[index].posterPath);
                        return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: imgUrl,
                                ),
                              ),
                            ));
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
