import 'package:flutter/material.dart';
import 'package:test_app_eds/models/posts/posts_model.dart';

class PostsList extends StatelessWidget {
  const PostsList({Key? key,
    required this.userName,
    required this.posts}) : super(key: key);

  final String userName;
  final List<UserPostsModel> posts;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$userName's posts"),),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(),
            title: Text('${posts[index].title}'),
            subtitle: Text('${posts[index].body}', maxLines: 2,overflow: TextOverflow.ellipsis,),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        );
      },),
    );
  }
}
