import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_rip/models/FeedParser.dart';

import 'package:flutter/material.dart';
import 'package:insta_rip/services/RequestFeed.dart';


class FeedViewModel extends ChangeNotifier {

  List<FeedParser> listModel = [];

  //Modeling data to list
  Future<void> fetchFeed() async {

    final storage = new FlutterSecureStorage();

    final response = await RequestFeed().fetchFeed();
    print("data: "+response.toString());
    this.listModel.clear();


    final data = jsonDecode(response.body);
    for (Map i in data) {
      listModel.add(FeedParser.fromJson(i));
    }

    notifyListeners();
  }
}
