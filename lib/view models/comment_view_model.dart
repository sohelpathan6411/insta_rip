import 'dart:convert';
import 'package:insta_rip/models/CommentParser.dart';
import 'package:flutter/material.dart';
import 'package:insta_rip/services/RequestComment.dart';

class CommentViewModel extends ChangeNotifier {
  List<CommentParser> listModel = [];

  //Modeling data to list
  Future<void> fetchComment() async {
    final response = await RequestComment().fetchComment();
    print("data: " + response.toString());
    this.listModel.clear();

    final data = jsonDecode(response.body);
    for (Map i in data) {
      listModel.add(CommentParser.fromJson(i));
    }

    notifyListeners();
  }
}
