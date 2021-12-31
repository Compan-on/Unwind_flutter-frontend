import "package:flutter/material.dart";

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  final postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Post"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.save)),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) => {},
                    maxLines: 7,
                    controller: postController,
                    decoration: const InputDecoration(
                        labelText: "How are you feeling ?",
                        alignLabelWithHint: true),
                    validator: (value) {
                      if ((value as String).trim().length < 1) {
                        return "Enter post content";
                      }
                      return null;
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
