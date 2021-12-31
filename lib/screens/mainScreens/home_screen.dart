import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../providers/post.dart";
import '../../widgets/post.dart';
import 'create_post.dart';

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
      body: _loading
          ? const Center(
              child: const CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshPosts(context),
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return Post(fetchedPosts[index]);
                },
                itemCount: fetchedPosts.length,
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //temp
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePost()));
        },
        child: const Icon(Icons.create),
      ),
    );
  }
}
