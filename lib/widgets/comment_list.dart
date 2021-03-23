import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:insta_rip/Helpers/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:insta_rip/models/CommentParser.dart';
import 'package:insta_rip/models/FeedParser.dart';
import 'package:insta_rip/view%20models/comment_view_model.dart';
import 'package:provider/provider.dart';

//Widget for comments
class CommentList extends StatefulWidget {
  final List<CommentParser> comments;

  CommentList({this.comments});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  String dummy = "https://i.ytimg.com/vi/AWjdhWFtVaY/default.jpg";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Color(COLOR_PRIMARY),
        title: Text(
          "Comments",
          style: TextStyle(
              color: Color(COLOR_TEXT_PRIMARY),
              letterSpacing: 0.5,
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(COLOR_BACKGROUND),
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: widget.comments.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Material(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                        imageUrl: dummy,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(
                                          strokeWidth: 1,
                                          backgroundColor: Colors.black,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Text(
                                    widget.comments[index].username,
                                    style: TextStyle(
                                      color: Color(COLOR_TEXT_PRIMARY),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.comments[index].comments,
                                    style: TextStyle(
                                      color: Color(COLOR_TEXT_PRIMARY),
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.favorite_border),
                                iconSize: 15,
                                onPressed: () {
                                  //TODO
                                },
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
