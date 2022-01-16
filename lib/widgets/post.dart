import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import "../providers/post.dart";
import "./alert.dart";
import "../screens/mainScreens/create_post.dart";

class Post extends StatefulWidget {
  final Map post;
  Post(this.post);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  Future<void> _deleteHandler(String postID) async {
    returnAlertValue(
            context, "Confirm Delete", "Do you want to delete this post ?")
        .then((value) async {
      if (value) {
        await Provider.of<Posts>(context, listen: false).deletePost(postID);
        showMessageAlert(context, "Post Deleted Successfully");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.post["userAvatar"]),
            ),
            title: Text(widget.post["userName"]),
            trailing: PopupMenuButton(
              child: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: "Edit",
                  onTap: () {
                    // print("Hello");
                    // // Navigator.of(context).pop();
                    // Navigator.of(context).pushNamed("/edit_post");
                    // print("World");
                  },
                  child: Row(children: const [
                    Icon(Icons.edit),
                    Text(
                      ' Edit',
                      style: TextStyle(fontSize: 14),
                    ),
                  ]),
                ),
                PopupMenuItem(
                  value: "Delete",
                  onTap: () => _deleteHandler(widget.post["_id"]),
                  child: Row(children: const [
                    Icon(Icons.delete),
                    Text(
                      ' Delete',
                      style: TextStyle(fontSize: 14),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              widget.post["postContent"],
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                DateFormat.yMMMMd()
                    .format(DateTime.parse(widget.post["created_at"]))
                    .toString(),
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          ListTile(
            leading: GestureDetector(
              child: (widget.post["likes"] as List)
                      .contains("rJqzNkAiOAc1bt786Y0z2qGLyT83")
                  ? const Icon(
                      FontAwesome.heart,
                      color: Color.fromRGBO(83, 109, 254, 1),
                    )
                  : const Icon(FontAwesome.heart_o),
              onTap: () async {
                await Provider.of<Posts>(context, listen: false).toggleLike(
                    widget.post["_id"], "rJqzNkAiOAc1bt786Y0z2qGLyT83");
              },
            ),
            trailing: const Icon(Ionicons.ios_paper_plane),
          ),
        ],
      ),
    );
  }
}
