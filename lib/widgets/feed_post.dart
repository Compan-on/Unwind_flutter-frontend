import "package:flutter/material.dart";
import "./alert.dart";
import 'package:intl/intl.dart';

class FeedPost extends StatefulWidget {
  // const FeedPost({Key? key}) : super(key: key);
  final Map<String, dynamic> Post;
  FeedPost(this.Post);

  @override
  _FeedPostState createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(widget.Post["_id"]),
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
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ((widget.Post["postContent"] as String).length > 130
                ? (widget.Post["postContent"] as String)
                        .replaceAll("\n", "")
                        .substring(0, 130) +
                    "..."
                : widget.Post["postContent"]),
            textAlign: TextAlign.justify,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              DateFormat.yMMMMd()
                  .format(DateTime.parse(widget.Post["created_at"]))
                  .toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                // leading: GestureDetector(
                //   child: const Icon(Icons.settings),
                //   onTap: () {},
                // ),
                trailing: (widget.Post["postContent"] as String).length > 130
                    ? GestureDetector(
                        child: const Text(
                          "Read More",
                          style: TextStyle(
                            color: Color.fromRGBO(83, 109, 254, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          showFeedAlert(context, widget.Post);
                        },
                      )
                    : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
