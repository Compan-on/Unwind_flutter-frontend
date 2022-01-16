import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;

const baseURL = "http://10.0.2.2:3000/posts";

class Posts with ChangeNotifier {
  List _posts = [];
  List _user_posts = [];

  List get posts {
    return [..._posts];
  }

  List get user_posts {
    return [..._user_posts];
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
          "_id": post["_id"],
          "userID": post["userID"],
          "userName": post["userName"],
          "userAvatar": post["userAvatar"],
          "postContent": post["postContent"],
          "created_at": post["created_at"],
          "likes": post["likes"] ?? []
        });
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

  Future<void> deletePost(String postID) async {
    final url = Uri.parse(baseURL + "/${postID}");
    try {
      final res = await http.delete(url);
      _posts.removeWhere((post) {
        return post["_id"] == postID;
      });
      notifyListeners();
    } catch (err) {
      print(err);
      rethrow;
    }
  }
  //EDIT POST

  //USER POSTS
  Future<void> fetchAndSetUserPosts(String userID) async {
    final url = Uri.parse(baseURL + "/" + userID);
    try {
      final res = await http.get(url);
      final extractedData = convert.jsonDecode(res.body) as List;
      if (extractedData == null) {
        return;
      }
      final List loadedPosts = [];
      extractedData.forEach((post) {
        loadedPosts.add({
          "_id": post["_id"],
          "userID": post["userID"],
          "userName": post["userName"],
          "userAvatar": post["userAvatar"],
          "postContent": post["postContent"],
          "created_at": post["created_at"],
          "likes": post["likes"] ?? []
        });
      });
      _user_posts = loadedPosts;
      notifyListeners();
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  //toggle likes
  Future<void> toggleLike(String postID, String userID) async {
    final url = Uri.parse(baseURL + "/" + postID + "/" + userID);
    try {
      final res = await http.post(
        url,
        body: convert.jsonEncode({}),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        encoding: convert.Encoding.getByName("utf-8"),
      );
      int index = _posts.indexWhere((post) => post["_id"] == postID);
      if ((_posts[index]["likes"] as List).contains(userID)) {
        (_posts[index]["likes"] as List).remove(userID);
      } else {
        (_posts[index]["likes"] as List).add(userID);
      }
      notifyListeners();
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
