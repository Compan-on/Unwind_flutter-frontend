import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final postText;
  Post(this.postText);
  // const Post({Key? key, p}) : super(key: key);

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
              backgroundImage: NetworkImage(
                  "https://cdn1.vectorstock.com/i/1000x1000/31/95/user-sign-icon-person-symbol-human-avatar-vector-12693195.jpg"),
            ),
            title: Text("Shivam Arora"),
          ),
          ListTile(
            title: Text(
              widget.postText,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14),
            ),
          ),
          ListTile(
            leading: Icon(Icons.turned_in_not),
            trailing: Icon(Icons.message_outlined),
          ),
        ],
      ),
    );
  }
}
