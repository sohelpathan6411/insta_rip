class CommentParser {
  String username, comments;

  CommentParser({this.username, this.comments});

  factory CommentParser.fromJson(Map<String, dynamic> json) => CommentParser(
        username: json["username"],
    comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {"username": username, "comments": comments};
}
