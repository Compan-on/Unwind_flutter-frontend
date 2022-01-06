import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;

const baseURL = "http://10.0.2.2:3000/posts";

class Posts with ChangeNotifier {
  List _posts = [];

  List get posts {
    return [..._posts];
  }

  Future<void> fetchAndSetPosts() async {
    final url = Uri.parse(baseURL + "/");
    try {
      final res = await http.get(url);
      final extractedData = convert.jsonDecode(res.body) as List;
      if (extractedData == null) {
        return;
      }
      final List loadedPosts = [];
      extractedData.forEach((post) {
        loadedPosts.add({
          "userID": post["userID"],
          "userName": post["userName"],
          "userAvatar": post["userAvatar"],
          "postContent": post["postContent"],
          "created_at": post["created_at"]
        });
        // print(post["created_at"] as String);
      });
      _posts = loadedPosts;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> addPost(Map<String, dynamic> postData) async {
    final url = Uri.parse(baseURL + "/");
    try {
      final res = await http.post(
        url,
        body: convert.jsonEncode({
          "userID": postData["userID"],
          "userName": postData["userName"],
          "userAvatar": postData["userAvatar"],
          "postContent": postData["postContent"],
        }),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        encoding: convert.Encoding.getByName("utf-8"),
      );
      notifyListeners();
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
