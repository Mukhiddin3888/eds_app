import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_eds/screens/albums_list/albums_list_screen.dart';
import 'package:test_app_eds/screens/posts_list/posts_list.dart';
import 'package:test_app_eds/screens/user_info/albums_bloc/albums_bloc.dart';
import 'package:test_app_eds/screens/user_info/posts_bloc/posts_bloc.dart';
import 'package:test_app_eds/utils/styles/styles.dart';
import 'package:test_app_eds/utils/styles/utils.dart';
import 'package:test_app_eds/widgets/error_button.dart';


class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.phone,
    required this.website,
    required this.compName,
    required this.bs,
    required this.street,
    required this.suite,
    required this.city,

  }) : super(key: key);

  final int id;
  final String name;
  final String userName;
  final String phone;
  final String email;
  final String website;
  final String compName;
  final String bs;
  final String street;
  final String suite;
  final String city;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(userName),),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AlbumsBloc(),),
          BlocProvider(create: (context) => PostsBloc(),
        )],
        child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: CircleAvatar(radius: 48,),
                      ),
                      UserInfoItem(name: name, title: 'Name',),
                      UserInfoItem(name: email, title: 'E-mail',),
                      UserInfoItem(name: phone, title: 'Phone',),
                      UserInfoItem(name: website, title: 'Website',),
                      UserInfoItem(name: compName, title: 'Company',),
                      UserInfoItem(name: bs, title: '     ',),
                      UserInfoItem(name: street, title: 'Address',),
                      UserInfoItem(name: suite, title: '     ',),
                      UserInfoItem(name: city, title: '     ',),

                      Align(
                          alignment: Alignment.topLeft,
                          child: Text('Posts',style: MyTextStyles.header2,)),

                      BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {

                      if(state is PostsInitial){
                        context.watch<PostsBloc>().add(GetPosts(userId: id));
                        return Container();
                      }
                      if(state is PostsLoading){
                        return Center(child: CircularProgressIndicator());
                      }
                      if(state is PostsLoaded){
                        return Column(
                          children: [
                            ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: (state.posts.length  <= 3) && (state.posts.length > 0) ? state.posts.length : 3,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: ListTile(
                                    title: Text('${state.posts[index].title}',style: MyTextStyles.header3,),
                                    subtitle: Text('${state.posts[index].body}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),),
                                );
                              },
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, CupertinoPageRoute(
                                        builder: (context) => PostsList(posts: state.posts,userName: userName,),));
                                    },
                                    child: Text('See all posts', style: MyTextStyles.header2.copyWith(color: Colors.blue),))),                          ],
                        );
                      }
                      if(state is PostsError){
                        return ErrorButton(onTap: (){
                          context.read<PostsBloc>().add(GetPosts(userId: id));
                        });
                      }else return SizedBox();

        },
),


                      SizedBox(height: 8,),

                      //TODO: implement better ui

                      BlocBuilder<AlbumsBloc, AlbumsState>(
                          builder: (context, state) {
                       if(state is AlbumsInitial){
                          context.watch<AlbumsBloc>().add(GetAlbums(userId: id, ));
                        return Container();
                      }
                        if(state is AlbumsLoading){
                          return Center(child: CircularProgressIndicator());
                      }
                      if(state is AlbumsLoaded){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('Albums', style: MyTextStyles.header2,)),
                            SizedBox(height: 16,),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('${state.albums[0].title}', style: MyTextStyles.header2,)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('${state.albums[1].title}', style: MyTextStyles.header2,)),
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('${state.albums[2].title}', style: MyTextStyles.header2,)),

                            Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, CupertinoPageRoute(
                                        builder: (context) => AlbumsListScreen(
                                          userName: userName, albums: state.albums,),));
                                    },
                                    child: Text('See all Albums', style: MyTextStyles.header2.copyWith(color: MyColors.blue),))),
                            SizedBox(height: 24,)
                          ],
                        );
                      }
                       if(state is LoadingError){
                         return ErrorButton(onTap: (){
                           context.read<AlbumsBloc>().add(GetAlbums(userId: id));
                         });
                       }
                      else return SizedBox();

                          },
                        ),


                    ],

                  ),
                ),
              ),
      ),
    );
  }
}

class AlbumPreViewItem extends StatelessWidget {
  const AlbumPreViewItem({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(8),
      width: 64,
    height: 64,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(image: NetworkImage(url)),
    ),);
  }
}

class UserInfoItem extends StatelessWidget {
  const UserInfoItem({
    Key? key,
    required this.name,
    required this.title,
  }) : super(key: key);

  final String name;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
            Text('$title ',style: MyTextStyles.header2,),
            Spacer(),
            Text('$name',style: MyTextStyles.body,),
          //    Spacer(),
            ],),
        ),
        Divider(),
      ],
    );
  }
}
