import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import "package:provider/provider.dart";
import "../../providers/post.dart";

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
                    : ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: StaggeredGrid.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              children: fetchedPosts.map((post) {
                                return StaggeredGridTile.count(
                                  crossAxisCellCount: 1,
                                  mainAxisCellCount:
                                      (post["postContent"] as String)
                                              .split(" ")
                                              .length /
                                          28,
                                  // add calculations for landscape orientation
                                  child: Container(
                                      key: Key(post["_id"]),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Text(post["postContent"])),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      )),
              ));
  }
}
