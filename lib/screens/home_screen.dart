import "package:flutter/material.dart";
import "../widgets/post.dart";
import 'create_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var demoText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Faucibus ornare suspendisse sed nisi lacus. Interdum velit laoreet id donec ultrices tincidunt arcu non. Volutpat est velit egestas dui id ornare arcu odio. Posuere lorem ipsum dolor sit amet consectetur. Massa id neque aliquam vestibulum morbi. Fringilla est ullamcorper eget nulla. At urna condimentum mattis pellentesque id nibh tortor. In est ante in nibh mauris. Eu turpis egestas pretium aenean pharetra magna ac placerat. Adipiscing elit ut aliquam purus sit amet luctus venenatis lectus. Pulvinar pellentesque habitant morbi tristique senectus. Volutpat lacus laoreet non curabitur gravida arcu ac. Tortor condimentum lacinia quis vel. Dictumst quisque sagittis purus sit amet volutpat. Tortor pretium viverra suspendisse potenti nullam ac.";
  var demoText2 =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A scelerisque purus semper eget. Tempor orci dapibus ultrices in.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Post(demoText),
            Post(demoText2),
            Post(demoText),
            Post(demoText2),
          ],
        ),
      ),
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
