import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_rip/Helpers/constants.dart';
import 'package:insta_rip/Helpers/helper.dart';
import 'package:insta_rip/models/CommentParser.dart';
import 'package:insta_rip/models/FeedParser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:insta_rip/view%20models/comment_view_model.dart';
import 'package:insta_rip/view%20models/feed_view_model.dart';
import 'package:insta_rip/widgets/comment_list.dart';
import 'package:provider/provider.dart';

// widgte for Feeds
class FeedList extends StatefulWidget {
  final List<FeedParser> feeds;
  final List<CommentParser> comments;
  Map<String, String> allValues;

  FeedList({this.feeds, this.comments, this.allValues});

  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {

  Map<String, String> allValues;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //allValues represents bookmark values
    setState(() {
      allValues =widget.allValues;
    });
  }

  //Refreshes feed data
  Future<void> _pullRefresh() async {
    Provider.of<FeedViewModel>(context, listen: false).fetchFeed();
  }

  @override
  Widget build(BuildContext context) {

    //callig local app storage
    final storage = new FlutterSecureStorage();

    return  RefreshIndicator(
      onRefresh: _pullRefresh, child: ListView.builder(
            itemCount: widget.feeds.length,
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
                        SizedBox(
                          height: 20,
                        ),
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
                                      imageUrl:
                                          widget.feeds[index].low_thumbnail,
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
                                  widget.feeds[index].channelname,
                                  style: TextStyle(
                                    color: Color(COLOR_TEXT_PRIMARY),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {
                                //TODO
                              },
                            ),
                          ],
                        )),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl: widget.feeds[index].high_thumbnail,
                            placeholder: (context, url) => Center(
                              child: new CircularProgressIndicator(
                                strokeWidth: 1,
                                backgroundColor: Colors.black,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    iconSize: 25,
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.mode_comment_outlined),
                                    iconSize: 25,
                                    onPressed: () {
                                      //TODO
                                      push(
                                          context,
                                          CommentList(
                                              comments: widget.comments));
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.share_outlined),
                                    iconSize: 25,
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: allValues
                                        .containsKey(widget.feeds[index].id)
                                    ? Icon(Icons.bookmark_border)
                                    : Icon(Icons.bookmark),
                                iconSize: 25,
                                onPressed: () async {
                                  //TODO
                                  if (allValues
                                      .containsKey(widget.feeds[index].id)) {
                                    await storage.delete(
                                        key: widget.feeds[index].id);
                                    setState(() {
                                      allValues.remove(widget.feeds[index].id);
                                    });
                                  } else {
                                    await storage.write(
                                        key: widget.feeds[index].id,
                                        value: widget.feeds[index].channelname);
                                    setState(() {
                                      allValues.putIfAbsent(
                                          widget.feeds[index].id,
                                          () =>
                                              widget.feeds[index].channelname);
                                    });
                                  }
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: ExpandableNotifier(
                            // <-- Provides ExpandableController to its children
                            child: Column(
                              children: [
                                widget.feeds[index].title.length > 50
                                    ? Expandable(
                                        // <-- Driven by ExpandableController from ExpandableNotifier
                                        collapsed: ExpandableButton(
                                          // <-- Expands when tapped on the cover photo
                                          child: RichText(
                                            text: new TextSpan(
                                              // Note: Styles for TextSpans must be explicitly defined.
                                              // Child text spans will inherit styles from parent
                                              children: <TextSpan>[
                                                new TextSpan(
                                                  text: widget
                                                      .feeds[index].title
                                                      .substring(0, 49),
                                                  style: new TextStyle(
                                                    letterSpacing: 0.5,
                                                    fontSize: 15,
                                                    wordSpacing: 0.5,
                                                    color: Color(
                                                        COLOR_TEXT_PRIMARY),
                                                  ),
                                                ),
                                                new TextSpan(
                                                  text: "...more",
                                                  style: new TextStyle(
                                                    letterSpacing: 0.5,
                                                    fontSize: 15,
                                                    wordSpacing: 0.5,
                                                    color: Color(
                                                        COLOR_TEXT_SECONDARY),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        expanded: Column(children: [
                                          Text(
                                            widget.feeds[index].title,
                                            style: new TextStyle(
                                              letterSpacing: 0.5,
                                              fontSize: 15,
                                              wordSpacing: 0.5,
                                              color: Color(COLOR_TEXT_PRIMARY),
                                            ),
                                          ),
                                        ]),
                                      )
                                    : Text(
                                        widget.feeds[index].title,
                                        style: new TextStyle(
                                          letterSpacing: 0.5,
                                          fontSize: 15,
                                          wordSpacing: 0.5,
                                          color: Color(COLOR_TEXT_PRIMARY),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),);
  }
}
