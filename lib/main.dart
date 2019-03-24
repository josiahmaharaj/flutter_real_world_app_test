import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './views/video_cell.dart';
import 'package:real_word_app/views/more_videos.dart';
// import './views//video_details.dart';

void main() => runApp(RealWordApp());

class RealWordApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RealWorldState();
  }
}

class RealWorldState extends State<RealWordApp> {
  var _isLoading = true;
  var _isListLoading = true;

  var videos;
  var videoDets;

  _fetchData() async {
    print("Attempting to fetch data from URL");

    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // print(response.body);
      final map = json.decode(response.body);
      final jsonVideos = map["videos"];

      setState(() {
        _isLoading = false;
        this.videos = jsonVideos;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('Real World App'),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                print("Reloading");
                _fetchData();
              },
            )
          ],
        ),
        body: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : new ListView.builder(
                  itemCount:
                      this.videos.length != null ? this.videos.length : 0,
                  itemBuilder: (context, i) {
                    final video = this.videos[i];
                    return FlatButton(
                      padding: EdgeInsets.all(0),
                      child: VideoCell(video),
                      onPressed: () {
                        print("Pressed: $i");
                        // _fetchDetails(i + 1);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new MoreVideos(video_id: i+1,)
                              )
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
