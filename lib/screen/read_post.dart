import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsondemoproject/model/post_dto.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */

class ReadPostPage extends StatefulWidget {
  ReadPostPage({Key? key, this.postDTO}) : super(key: key);
  final PostDTO? postDTO;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ReadPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Read Post"),
        ),
        body: ListView(
          children: [
             ListTile(
              title: Text(widget.postDTO!.title.toString()),
              subtitle: Container(
                  margin: const EdgeInsets.only(top: 10.0 ),
                  child: Text(widget.postDTO!.body.toString())),
            )
          ],
          shrinkWrap: true,
        ));
  }
}
