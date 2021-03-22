import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestComment {

  /// Fetching comments
  Future fetchComment() async {
    String url  = "http://cookbookrecipes.in/test.php";
    print(url);
    final response = await http.get(Uri.parse(url));
    print("response"+response.body.toString());
    if(response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Unable to perform request comment!");
    }
  }
}