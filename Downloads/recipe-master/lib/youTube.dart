import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
//void main() => runApp(new Youtube("tea"));

class Youtube extends StatefulWidget {
  final String item;
  const Youtube(this.item);
  _YoutubeState createState() => new _YoutubeState();
}


class _YoutubeState extends State<Youtube> {
  void playYoutubeVideo(String url) {
    print(url);
    url=url.replaceAll(new RegExp(r"\s+"), "");
    print(url);
    String url1="https://www.youtube.com/watch?v=wgTBLj7rMPM";
    FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: "AIzaSyCLzsn0arN1YfwcIKdRjcyBFfLOirXwPik",
      // videoUrl: "https://www.youtube.com/watch?v=wgTBLj7rMPM",
      videoUrl: url,
    );
  }
  static String key = "AIzaSyCLzsn0arN1YfwcIKdRjcyBFfLOirXwPik";// ** ENTER YOUTUBE API KEY HERE **

  YoutubeAPI ytApi = new YoutubeAPI(key);
  List<YT_API> ytResult = [];

  callAPI() async {
    print('UI callled');

    String query = widget.item+"Recipe";
    ytResult = await ytApi.search(query);
    setState(() {
      print('UI Updated');
    });
  }
  @override
  void initState() {
    super.initState();
    callAPI();
    print('hello');
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: SafeArea(
        child: new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.lightGreen,
              title: Text('Youtube API'),
            ),
            body: new Container(
              child: ListView.builder(
                  itemCount: ytResult.length,
                  itemBuilder: (_, int index) => listItem(index)
              ),
            )
        ),
      ),
    );
  }
  Widget listItem(index){
    print(ytResult[index].url);
    print(ytResult[index].url.replaceAll(new RegExp(r"\s+"), ""));
    return new Card(
      child: InkWell(
        onTap: () {
          print("tapped");
          playYoutubeVideo(ytResult[index].url);
        },
        child:new Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          padding: EdgeInsets.all(12.0),
          child:new Row(
            children: <Widget>[
              new Image.network(ytResult[index].thumbnail['default']['url'],),
              new Padding(padding: EdgeInsets.only(right: 20.0)),
              new Expanded(child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      ytResult[index].title,
                      softWrap: true,
                      style: TextStyle(fontSize:18.0),
                    ),
                    new Padding(padding: EdgeInsets.only(bottom: 1.5)),
                    new Text(
                      ytResult[index].channelTitle,
                      softWrap: true,
                    ),
                    new Padding(padding: EdgeInsets.only(bottom: 3.0)),
                    new Text(
                      ytResult[index].url,

                      softWrap: true,
                    ),
                  ]
              ))
            ],
          ),
        ),
      ),
    );
  }
}