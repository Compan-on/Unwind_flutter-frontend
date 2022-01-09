import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            trailing: PopupMenuButton(
              child: const Icon(Icons.more_vert),
              // onSelected: (result) {},
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: "Edit",
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
                  onTap: () => {},
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
          const ListTile(
            leading: Icon(Icons.turned_in_not),
            trailing: Icon(Icons.message_outlined),
          ),
        ],
      ),
    );
  }
}
