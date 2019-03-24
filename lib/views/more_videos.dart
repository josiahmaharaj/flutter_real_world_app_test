import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MoreVideos extends StatefulWidget {
  final Widget child;
  final video_id;

  MoreVideos({Key key, this.child, @required this.video_id}) : super(key: key);

  _MoreVideosState createState() => _MoreVideosState(video_id);
}

class _MoreVideosState extends State<MoreVideos> {
  @override
  final int video_id;
  var video;
  var _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDetails(video_id);
  }

  _fetchDetails(int id) async {
    print("Fetching Details");

    final url = "https://api.letsbuildthatapp.com/youtube/course_detail?id=" +
        video_id.toString();
    final response = await http.get(url);
    //print(url);

    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final videoDetails = map;
      setState(() {
        this.video = videoDetails;
        _isLoading = false;
      });
    }
  }

  _MoreVideosState(this.video_id);
  Widget build(BuildContext context) {
    return MaterialApp(
      //  child: widget.child,
      home: Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(null),
          ),
          title: Text('More Videos'),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: video.length,
                itemBuilder: (BuildContext context, int index) {
                  return FlatButton(
                    onPressed: (){
                      print(video[index+1]['link']);
                    },
                    padding: EdgeInsets.all(0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              height: 100.0,
                              child: Image.network(video[index]['imageUrl']),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                video[index]['name'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(video[index]['duration'])
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
