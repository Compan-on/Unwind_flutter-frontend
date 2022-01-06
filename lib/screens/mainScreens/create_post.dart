import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../providers/post.dart";
import "../../widgets/alert.dart";

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  final postController = TextEditingController();

  Map<String, dynamic> postData = {
    "userID": "rJqzNkAiOAc1bt786Y0z2qGLyT83",
    "userName": "Shivam Arora",
    "userAvatar":
        "https://cdn1.vectorstock.com/i/1000x1000/31/95/user-sign-icon-person-symbol-human-avatar-vector-12693195.jpg",
    "postContent": ""
  };

  Future<void> _submitPostHandler(postProvider, postData) async {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      returnAlertValue(
              context, "Confirm Save", "Do you want to save this post ?")
          .then((value) async {
        if (value as bool) {
          await postProvider.addPost(postData);
          showMessageAlert(context, "Post Saved Successfully").then((value) {
            if (value) {
              Navigator.of(context).pop();
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) {
            return Posts();
          }),
        ],
        child: Consumer<Posts>(
          builder: (ctx, postProvider, child) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Create Post"),
                  actions: [
                    IconButton(
                        onPressed: () =>
                            _submitPostHandler(postProvider, postData),
                        icon: const Icon(Icons.save)),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        onChanged: (value) {
                          postData["postContent"] = value;
                        },
                        maxLines: 7,
                        controller: postController,
                        decoration: const InputDecoration(
                            labelText: "How are you feeling ?",
                            alignLabelWithHint: true),
                        validator: (value) {
                          if ((value as String).trim().length < 1) {
                            return "Enter Post Content";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          // child: ,
        ));
  }
}
