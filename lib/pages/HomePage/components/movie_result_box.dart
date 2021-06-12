import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:torrpix/models/movie.dart';
import 'package:torrpix/pages/DetailsPage/components/webTor.dart';
import 'package:torrpix/providers/homePageProvider.dart';
import 'package:torrpix/services/searchTorrent.dart';

class MovieResultBox extends StatefulWidget {
  const MovieResultBox({Key? key}) : super(key: key);

  @override
  _MovieResultBoxState createState() => _MovieResultBoxState();
}

class _MovieResultBoxState extends State<MovieResultBox> {
  bool forceRedraw = true;



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<HomePageProvider>(
        builder: (_,provider,__) => provider.isHomePageProcessing
        ? Center(child : CircularProgressIndicator())
        : provider.moviesListLength > 0 ?
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
                var currentMovie =  provider.moviesList![index];
                currentMovie.toggleIsExpanded = !isExpanded;
                setState(() {
                  forceRedraw = !forceRedraw;
                });
            },
            children: provider.moviesList!.map((Movie item) {
              var poster = item.posterPath ?? '';
              if(item.posterPath == ''){
                poster = 'https://cdn4.iconfinder.com/data/icons/planner-color/64/popcorn-movie-time-512.png';
              }else poster = 'https://image.tmdb.org/t/p/original' + poster;
              return ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                      title: Text(item.originalTitle ?? '' ,
                      style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                  )),
                    subtitle: Text(item.overview ?? '' , maxLines: 3, overflow: TextOverflow.ellipsis),
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                      minWidth: 64,
                      minHeight: 44,
                      maxWidth: 64,
                      maxHeight: 104,
                    ),
                    child: Image.network(poster, fit: BoxFit.fitHeight),
                    )
                  );
                },
                body: item.torrents!.length > 0 ? SizedBox(
                  height: 100.0,
                  child: ListView.builder(
                    itemCount: item.torrents!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index){
                      return ListTile(
                        onTap: (){
                          var hashUrl = "magnet:?xt=urn:btih:"+(item.torrents![index].hash ?? '')+"&tr=udp://tracker.cyberia.is:6969/announce&tr=udp://tracker.port443.xyz:6969/announce&tr=http://tracker3.itzmx.com:6961/announce&tr=udp://tracker.moeking.me:6969/announce&tr=http://vps02.net.orel.ru:80/announce&tr=http://tracker.openzim.org:80/announce&tr=udp://tracker.skynetcloud.tk:6969/announce&tr=https://1.tracker.eu.org:443/announce&tr=https://3.tracker.eu.org:443/announce&tr=http://re-tracker.uz:80/announce&tr=https://tracker.parrotsec.org:443/announce&tr=udp://explodie.org:6969/announce&tr=udp://tracker.filemail.com:6969/announce&tr=udp://tracker.nyaa.uk:6969/announce&tr=udp://retracker.netbynet.ru:2710/announce&tr=http://tracker.gbitt.info:80/announce&tr=http://tracker2.dler.org:80/announce";
                          Clipboard.setData(ClipboardData(text: hashUrl));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WebTor()));
                        },
                        title: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text('Quality: ' + (item.torrents![index].quality ??  ''), style: TextStyle(color : Colors.black)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text('Size: ' + (item.torrents![index].size ??  ''), style: TextStyle(color : Colors.black)),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text('Seeders: ' + item.torrents![index].seeds.toString(), style: TextStyle(color : Colors.black)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text('Peers: ' +  item.torrents![index].peers.toString(), style: TextStyle(color : Colors.black)),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ) : Center(child: Text('No Torrents found'),),
                isExpanded: item.getIsExpanded,
              );
            }).toList(),
          )
            : Center(
                child: Text('Nothing to show here!'),
        ),
      )
    );
  }
}
