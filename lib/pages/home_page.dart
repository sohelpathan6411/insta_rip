import 'dart:ui';

import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_rip/Helpers/constants.dart';
import 'package:insta_rip/view%20models/comment_view_model.dart';
import 'package:insta_rip/view%20models/feed_view_model.dart';
import 'package:insta_rip/widgets/feed_list.dart';
import 'package:provider/provider.dart';

class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  String sel_date = "loading...";
  DateTime selectedDate;
  int selectedIndex = 0;

  final storage = new FlutterSecureStorage();
  Map<String, String> allValues;
  bool _isloaded = false;

  Future getBookMarks() async {
    allValues = await storage.readAll();
    setState(() {
      _isloaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    //Initial data fethed
    Provider.of<CommentViewModel>(context, listen: false).fetchComment();
    Provider.of<FeedViewModel>(context, listen: false).fetchFeed();

    getBookMarks();
  }

  @override
  Widget build(BuildContext context) {
    //providers(Feeds and comments)
    final feedProvider = Provider.of<FeedViewModel>(context);
    final commentProvider = Provider.of<CommentViewModel>(context);

    tabbody(int index) {
      switch (index) {
        case 0:
          return Container(
            color: Color(COLOR_BACKGROUND),
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            child: Column(children: <Widget>[
              Expanded(
                  child: FeedList(
                feeds: feedProvider.listModel,
                comments: commentProvider.listModel,
                allValues: allValues,
              )),
            ]),
          );
        case 1:
          return Container(
              color: Color(COLOR_BACKGROUND),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Center(
                child: Text(
                  'Comming soon',
                  style: TextStyle(
                      color: Color(COLOR_TEXT_PRIMARY),
                      letterSpacing: 0.5,
                      fontSize: 25),
                ),
              ));
        case 2:
          return Container(
              color: Color(COLOR_BACKGROUND),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Center(
                child: Text(
                  'Comming soon',
                  style: TextStyle(
                      color: Color(COLOR_TEXT_PRIMARY),
                      letterSpacing: 0.5,
                      fontSize: 25),
                ),
              ));
        case 3:
          return Container(
              color: Color(COLOR_BACKGROUND),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Center(
                child: Text(
                  'Comming soon',
                  style: TextStyle(
                      color: Color(COLOR_TEXT_PRIMARY),
                      letterSpacing: 0.5,
                      fontSize: 25),
                ),
              ));
        case 4:
          return Container(
              color: Color(COLOR_BACKGROUND),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Text(
                'Comming soon',
                style: TextStyle(
                    color: Color(COLOR_TEXT_PRIMARY),
                    letterSpacing: 0.5,
                    fontSize: 25),
              ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(COLOR_PRIMARY),
        title: Text(
          APP_TITLE,
          style: TextStyle(
              color: Color(COLOR_TEXT_PRIMARY),
              letterSpacing: 0.5,
              fontSize: 25),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.camera_alt, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.send, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.white,
            selectedItemBorderColor: Colors.grey.shade100,
            selectedItemBackgroundColor: Colors.black,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(iconData: Icons.category_outlined, label: "Home"),
          FFNavigationBarItem(iconData: Icons.search_outlined, label: 'Search'),
          FFNavigationBarItem(
              iconData: Icons.video_collection_outlined, label: "Story"),
          FFNavigationBarItem(
              iconData: Icons.bookmark_border, label: "Collection"),
          FFNavigationBarItem(
              iconData: Icons.account_circle_outlined, label: "Account"),
        ],
      ),
      //view as per index or tab selected
      body: _isloaded == true
          ? tabbody(selectedIndex)
          : Center(
              child: new CircularProgressIndicator(
                strokeWidth: 1,
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
    );
  }
}
