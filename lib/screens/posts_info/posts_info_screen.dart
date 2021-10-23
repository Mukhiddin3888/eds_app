import 'package:flutter/material.dart';

class PostsInfoScreen extends StatelessWidget {
  const PostsInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(),

          )
        ],),
    );
  }
}
