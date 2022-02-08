import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../providers/post.dart";
import '../../widgets/post.dart';
import "../../widgets/user_drawer.dart";
import 'package:flutter_icons/flutter_icons.dart';
import "package:firebase_auth/firebase_auth.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refreshPosts(BuildContext context) async {
    await Provider.of<Posts>(context, listen: false).fetchAndSetPosts();
  }

  bool _loading = true;
  @override
  void initState() {
    if (_loading) {
      _refreshPosts(context);
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fetchedPosts = Provider.of<Posts>(context).posts;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 240, 254, 1),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshPosts(context),
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
                  : ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return Post(fetchedPosts[index],
                            FirebaseAuth.instance.currentUser!.uid);
                      },
                      itemCount: fetchedPosts.length,
                    ))),
    );
  }
}
