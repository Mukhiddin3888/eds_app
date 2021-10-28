import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:test_app_eds/models/posts/posts_model.dart';
import 'package:test_app_eds/screens/posts_info/bloc/comments_bloc.dart';
import 'package:test_app_eds/screens/posts_info/modal_bottom_sheet.dart';
import 'package:test_app_eds/utils/styles/colors.dart';
import 'package:test_app_eds/utils/styles/styles.dart';
import 'package:test_app_eds/widgets/error_button.dart';

class PostsInfoScreen extends StatelessWidget {
  const PostsInfoScreen({Key? key, required this.post}) : super(key: key);

  final UserPostsModel post;

  @override
  Widget build(BuildContext context) {

    final TextEditingController controllerName = TextEditingController();
    final TextEditingController controllerEmail = TextEditingController();
    final TextEditingController controllerBody = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('${post.title}'),),
      body: BlocProvider(
        create: (context) => CommentsBloc(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: ListTile(
                  minVerticalPadding: 8,
                  //leading: CircleAvatar(),
                  title: Text('${post.title}'),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${post.body}'),
                  ),
                ),
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
                    return Column(
                      children: [
                        CommentsListItem(state: state.comments,),
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return BottomSheetComments(onSendTap: () { Navigator.pop(context); },
                                  controllerBody: controllerBody,
                                    controllerEmail: controllerEmail,
                                    controllerName: controllerName,
                                  );
                                });

                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                              alignment: Alignment.center,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: MyColors.blue,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Text('Post comments',style: MyTextStyles.header3.copyWith(color: MyColors.white),)),
                        ),
                      ],
                    );

                  }
                  if(state is LoadingError){
                    var lcomments =  Hive.box<List>('comments').get('comment${post.id}')?? []  ;
                    return lcomments.length > 0 ?

                    Column(
                      children: [
                        CommentsListItem(state: lcomments,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                            alignment: Alignment.center,
                            height: 48,
                            decoration: BoxDecoration(
                                color: MyColors.blue,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text('Please be Online to Post Comments',style: MyTextStyles.header3.copyWith(color: MyColors.white),)),
                      ],
                    )

                     : ErrorButton(onTap: (){context.read<CommentsBloc>().add(GetComment(postId: post.id));},);
                  }
                  else return SizedBox();
                },
              ),

            ],),
        ),
      ),
    );
  }
}

class CommentsListItem extends StatelessWidget {
  const CommentsListItem({
    Key? key,
    required this.state,
  }) : super(key: key);

  final state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.length,
      itemBuilder: (context, index) {
        return ListTile(
          isThreeLine: true,
          minVerticalPadding: 8,
          leading: CircleAvatar(),
          title: Text('${state[index].name}'),
          subtitle: Padding(
            padding: const EdgeInsets.all(8),
            child: Text('${state[index].body}',),
          ),


        );
      },);
  }
}


