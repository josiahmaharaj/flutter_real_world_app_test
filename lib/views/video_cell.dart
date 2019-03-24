import 'package:flutter/material.dart';

class VideoCell extends StatelessWidget {
  final video;

  VideoCell(this.video);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(video["imageUrl"]),
              Container(
                height: 16,
              ),
              Text(
                video["name"],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}