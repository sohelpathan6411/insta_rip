import 'package:flutter/material.dart';
import 'package:insta_rip/pages/home_page.dart';
import 'package:insta_rip/view%20models/comment_view_model.dart';
import 'package:insta_rip/view%20models/feed_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  //using MultiProvider for feeds and comments
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => FeedViewModel(),
              child: home_page(),
            ),
            ChangeNotifierProvider(
              create: (context) => CommentViewModel(),
              child: home_page(),
            ),
          ],
          child: home_page(),
        ));
  }
}
