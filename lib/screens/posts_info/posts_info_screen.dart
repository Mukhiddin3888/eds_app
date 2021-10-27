import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:test_app_eds/models/posts/posts_model.dart';
import 'package:test_app_eds/screens/posts_info/bloc/comments_bloc.dart';
import 'package:test_app_eds/widgets/error_button.dart';

class PostsInfoScreen extends StatelessWidget {
  const PostsInfoScreen({Key? key, required this.post}) : super(key: key);

  final UserPostsModel post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${post.title}'),),
      body: BlocProvider(
        create: (context) => CommentsBloc(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                //leading: CircleAvatar(),
                title: Text('${post.title}'),
                subtitle: Text('${post.body}'),
              ),
              SizedBox(height: 24,),
              BlocBuilder<CommentsBloc, CommentsState>(
                builder: (context, state) {
                  if(state is CommentsInitial){
                    context.watch<CommentsBloc>().add(GetComment(postId: post.id));
                  }
                  if(state is CommentsLoading){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(state is CommentsLoaded){
                    return ListView.builder(
                      padding: EdgeInsets.all(8),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(),
                          title: Text('${state.comments[index].email}'),
                          subtitle: Text('${state.comments[index].body}'),
                        );
                      },);

                  }
                  if(state is LoadingError){
                    var lcomments =  Hive.box<List>('comments').get('comment${post.id}')?? []  ;
                    return lcomments.length > 0 ?

                    ListView.builder(
                      padding: EdgeInsets.all(8),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lcomments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(),
                          title: Text('${lcomments[index].email}'),
                          subtitle: Text('${lcomments[index].body}'),
                        );
                      },)

                     : ErrorButton(onTap: (){context.read<CommentsBloc>().add(GetComment(postId: post.id));},);
                  }
                  else return SizedBox();
                },
              )
            ],),
        ),
      ),
    );
  }
}


