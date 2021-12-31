import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "dart:convert";

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
      final extractedData = jsonDecode(res.body) as List;
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
        });
      });
      _posts = loadedPosts;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
    notifyListeners();
  }
}
