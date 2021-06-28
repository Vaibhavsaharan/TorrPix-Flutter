import 'package:flutter/material.dart';
import 'package:torrpix/ui/DetailsPage/components/movieDetails.dart';
import 'package:torrpix/ui/DetailsPage/components/webTor.dart';
import 'package:flutter/services.dart';

class TorrentList extends StatelessWidget {
  TorrentList({required this.torrents});
  final List<Torrent> torrents;


  @override
  Widget build(BuildContext context) {
    return Card(child: Container(child: _torrentList(torrents)));
  }
}
ListView _torrentList(data) {

  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        var hashurl = "magnet:?xt=urn:btih:"+data[index].hash+"&tr=udp://tracker.cyberia.is:6969/announce&tr=udp://tracker.port443.xyz:6969/announce&tr=http://tracker3.itzmx.com:6961/announce&tr=udp://tracker.moeking.me:6969/announce&tr=http://vps02.net.orel.ru:80/announce&tr=http://tracker.openzim.org:80/announce&tr=udp://tracker.skynetcloud.tk:6969/announce&tr=https://1.tracker.eu.org:443/announce&tr=https://3.tracker.eu.org:443/announce&tr=http://re-tracker.uz:80/announce&tr=https://tracker.parrotsec.org:443/announce&tr=udp://explodie.org:6969/announce&tr=udp://tracker.filemail.com:6969/announce&tr=udp://tracker.nyaa.uk:6969/announce&tr=udp://retracker.netbynet.ru:2710/announce&tr=http://tracker.gbitt.info:80/announce&tr=http://tracker2.dler.org:80/announce";
        return Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Clipboard.setData(ClipboardData(text: hashurl));
                Navigator.push(context, MaterialPageRoute(builder: (context) => WebTor()));
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _torrentTile(data[index].quality+" "+data[index].type+" "+data[index].size, hashurl),
                ),
              ),
            ),
            Divider(),
          ],
        );
      });
}

ListTile _torrentTile(String title, String magnetLink) => ListTile(
    isThreeLine: false,
    enabled: true,
    title: Text(title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(magnetLink, maxLines: 3, overflow: TextOverflow.ellipsis)
);
