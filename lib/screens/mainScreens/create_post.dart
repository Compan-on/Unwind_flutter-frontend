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

  Future<void> _submitPostHandler(postData) async {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      returnAlertValue(
              context, "Confirm Save", "Do you want to save this post ?")
          .then((value) async {
        if (value as bool) {
          await Provider.of<Posts>(context).addPost(postData);
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(238, 240, 254, 1),
        // resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: const Text("Create Post"),
        //   actions: [
        //     IconButton(
        //         onPressed: () => _submitPostHandler(postData),
        //         icon: const Icon(Icons.save)),
        //   ],
        // ),
        body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: (Radius.circular(20)),
                  bottomRight: (Radius.circular(20)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://cdn1.vectorstock.com/i/1000x1000/31/95/user-sign-icon-person-symbol-human-avatar-vector-12693195.jpg"),
                      ),
                      title: Text("Shivam Arora"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          postData["postContent"] = value;
                        },
                        maxLines: 7,
                        controller: postController,
                        decoration: const InputDecoration(
                          labelText: "How are you feeling ?",
                          floatingLabelStyle: TextStyle(
                            color: Color.fromRGBO(83, 109, 254, 1),
                          ),
                          alignLabelWithHint: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(83, 109, 254, 1),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if ((value as String).trim().length < 1) {
                            return "Enter Post Content";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(83, 109, 254, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text('Post'))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
