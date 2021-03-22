class FeedParser {
  String id,
      channelname,
      title,
      high_thumbnail,
      low_thumbnail,
      medium_thumbnail;

  FeedParser(
      {this.id,
      this.channelname,
      this.title,
      this.low_thumbnail,
      this.high_thumbnail,
      this.medium_thumbnail});

  factory FeedParser.fromJson(Map<String, dynamic> json) => FeedParser(
        id: json["id"],
        channelname: json["channelname"],
        title: json["title"],
        high_thumbnail: json["high thumbnail"],
        low_thumbnail: json["low thumbnail"],
        medium_thumbnail: json["medium thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "channelname": channelname,
        "title": title,
        "high thumbnail": high_thumbnail,
        "low thumbnail": low_thumbnail,
        "medium thumbnail": medium_thumbnail,
      };
}
