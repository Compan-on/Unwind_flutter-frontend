import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final Map post;
  Post(this.post);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.post["userAvatar"]),
            ),
            title: Text(widget.post["userName"]),
          ),
          ListTile(
            title: Text(
              widget.post["postContent"],
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.turned_in_not),
            trailing: Icon(Icons.message_outlined),
          ),
        ],
      ),
    );
  }
}
