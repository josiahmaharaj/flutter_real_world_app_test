import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  // final video_id;
  @override
  State<StatefulWidget> createState() {
    return new DetailsPageState();
  }
}

class DetailsPageState extends State<DetailsPage> {
  // var isListLoading = true;
  // DetailsPage(this.video);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text("Details Page")),
        body: Center(
          child: ListView.builder(
            itemCount: video.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
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
                          Text(video[index]['name'], style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(video[index]['duration'])
                        ],
                      ),
                  )
                ],
              );
            },
          ),
        ));
  }
}