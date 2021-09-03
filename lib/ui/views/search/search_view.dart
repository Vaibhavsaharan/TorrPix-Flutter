import 'package:flutter/material.dart';
import 'package:flutter_torrent_streamer/flutter_torrent_streamer.dart';
import 'package:stacked/stacked.dart';
import 'package:torrpix/ui/views/search/search_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  bool isStreamReady = false;
  int progress = 0;

  @override
  void initState() {
    TorrentStreamer.init();
    super.initState();
    _addTorrentListeners();
  }

  void _addTorrentListeners() {
    TorrentStreamer.addEventListener('progress', (data) {
      setState(() => progress = data['progress']);
    });

    TorrentStreamer.addEventListener('ready', (_) {
      setState(() => isStreamReady = true);
    });
  }

  Future<void> _startDownload() async {
    await TorrentStreamer.start('magnet:?xt=urn:btih:8bd7409fb555f9fedfcb7f447bcf1cb20555a591&dn=After+%282019%29+%5BBluRay%5D+%5B1080p%5D+%5BYTS.LT%5D');
  }

  Future<void> _openVideo(BuildContext context) async {
    if (progress == 100) {
      await TorrentStreamer.launchVideo();
    } else {
      showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
                title: new Text('Are You Sure?', style:  TextStyle(color: Colors.black),),
                content: new Text('Playing video while it is still downloading is experimental and only works on limited set of apps.', style:  TextStyle(color: Colors.black),),
                actions: <Widget>[
                  TextButton(
                      child: new Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }
                  ),
                  TextButton(
                      child: new Text("Yes, Proceed"),
                      onPressed: () async {
                        await TorrentStreamer.launchVideo();
                        Navigator.of(context).pop();
                      }
                  )
                ]
            );
          },
          context: context
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
        viewModelBuilder: () => SearchViewModel(),
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                              child: Text('Start Download'),
                              onPressed: _startDownload
                          ),
                          Container(height: 8),
                          ElevatedButton(
                              child: Text('Play Video'),
                              onPressed: () => _openVideo(context)
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max
                    ),
                    padding: EdgeInsets.all(16)
                )
              ),
        ),
    );
  }
}
