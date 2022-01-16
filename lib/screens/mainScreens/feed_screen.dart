import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import "package:provider/provider.dart";
import "../../providers/post.dart";

import "../../widgets/feed_post.dart";

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Future<void> _refreshUserPosts(BuildContext context) async {
    await Provider.of<Posts>(context, listen: false)
        .fetchAndSetUserPosts("rJqzNkAiOAc1bt786Y0z2qGLyT83");
  }

  bool _loading = true;
  @override
  void initState() {
    if (_loading) {
      _refreshUserPosts(context);
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fetchedPosts = Provider.of<Posts>(context).user_posts;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(238, 240, 254, 1),
        body: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshUserPosts(context),
                child: (fetchedPosts.length == 0
                    ? ListView.builder(
                        itemBuilder: (_, index) {
                          return Container(
                            padding: const EdgeInsets.only(top: 50),
                            child: const Text("No Post Found"),
                            alignment: Alignment.center,
                          );
                        },
                        itemCount: 1,
                      )
                    : GridView.count(
                        physics: AlwaysScrollableScrollPhysics(),
                        children: fetchedPosts.map((post) {
                          return FeedPost(post);
                        }).toList(),
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.85,
                      ))));
  }
}
