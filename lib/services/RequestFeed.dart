import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestFeed {

  //Fetching feeds data
  Future fetchFeed() async {
    String url  = "https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas";
    print(url);
    final response = await http.get(Uri.parse(url));
    print("response"+response.body.toString());
    if(response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}