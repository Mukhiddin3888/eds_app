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
              ListTile(
                minVerticalPadding: 8,
                //leading: CircleAvatar(),
                title: Text('${post.title}'),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${post.body}'),
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
                        ListView.builder(
                          padding: EdgeInsets.all(8),
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.comments.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              isThreeLine: true,
                              minVerticalPadding: 8,
                              leading: CircleAvatar(),
                              title: Text('${state.comments[index].name}'),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text('${state.comments[index].body}',),
                              ),


                            );
                          },),
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Comment',style: MyTextStyles.header2,)),


                                          CustomTextField(controller: controllerName, maxLines: 2, hint: 'Name',inputType: TextInputType.name, ),
                                          CustomTextField(controller: controllerEmail, maxLines: 1, hint: 'E-mail',inputType: TextInputType.emailAddress,),
                                          CustomTextField(controller: controllerBody, maxLines: 4, hint: 'Comments',inputType: TextInputType.text,),
                                          GestureDetector(
                                            onTap:  (){ } ,

                                            child: Container(
                                                alignment: Alignment.center,
                                                height: 48,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: MyColors.blue,
                                                    borderRadius: BorderRadius.circular(8)
                                                ),
                                                child: Text('Send',style: MyTextStyles.header2.copyWith(color: MyColors.white),)),
                                          ),


                                        ],
                                      ),
                                    ),
                                  );
                                });

                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 48,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: MyColors.blue,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8))
                              ),
                              child: Text('Post comments',style: MyTextStyles.header2.copyWith(color: MyColors.white),)),
                        ),
                      ],
                    );

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
              ),

            ],),
        ),
      ),
    );
  }
}


