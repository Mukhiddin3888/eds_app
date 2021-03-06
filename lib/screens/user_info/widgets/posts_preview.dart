import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_eds/screens/posts_info/posts_info_screen.dart';
import 'package:test_app_eds/screens/posts_list/posts_list.dart';
import 'package:test_app_eds/utils/styles/utils.dart';

class PostsPreView extends StatelessWidget {
  const PostsPreView({
    Key? key,
    required this.userName,
    required this.state,
  }) : super(key: key);

  final String userName;
  final state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: (state.length <= 3) &&
              (state.length > 0)
              ? state.length
              : 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => PostsInfoScreen(post: state[index]),));
                },
                title: Text(
                  '${state[index].title}',
                  style: MyTextStyles.header3,
                ),
                subtitle: Text(
                  '${state[index].body}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            );
          },
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => PostsList(
                          posts: state,
                          userName: userName,
                        ),
                      ));
                },
                child: Text(
                  'See all posts',
                  style: MyTextStyles.header2
                      .copyWith(color: Colors.blue),
                ))),
      ],
    );
  }
}
