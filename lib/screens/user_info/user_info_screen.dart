import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_eds/screens/user_info/albums_bloc/albums_bloc.dart';
import 'package:test_app_eds/screens/user_info/posts_bloc/posts_bloc.dart';
import 'package:test_app_eds/utils/styles/styles.dart';


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

                      Row(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text('Posts',style: MyTextStyles.header2,)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded,size: 20,)
                        ],
                      ),

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
                        return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (state.posts.length  <= 3) && (state.posts.length > 0) ? state.posts.length : 3,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text('${state.posts[index].title}',style: MyTextStyles.header3,),
                              subtitle: Text('${state.posts[index].body}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),);
                          },
                        );
                      }
                      if(state is PostsError){
                        return Text('Error while loading Posts');
                      }else return SizedBox();

        },
),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text('See all posts', style: MyTextStyles.header2.copyWith(color: Colors.blue),)),

              //TODO: implement better ui
                      BlocBuilder<AlbumsBloc, AlbumsState>(
                          builder: (context, state) {
                       if(state is AlbumsInitial){
                          context.watch<AlbumsBloc>().add(GetAlbums(userId: id));
                        return Container();
                      }
                        if(state is AlbumsLoading){
                          return Center(child: CircularProgressIndicator());
                      }
                      if(state is AlbumsLoaded){
                        return Row(
                          children: [
                            AlbumPreViewItem(url: 'https://via.placeholder.com/150/24f355',
                              title: state.albums[0].title,),
                            AlbumPreViewItem(url: 'https://via.placeholder.com/150/24f355',
                              title: state.albums[1].title,),
                            AlbumPreViewItem(url: 'https://via.placeholder.com/150/24f355',
                              title: state.albums[2].title,),
                          ],
                        );
                      }
                       if(state is LoadingError){
                         return Text('Error while loading Posts');
                       }
                      else return SizedBox();

                          },
                        ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text('See all Albums', style: MyTextStyles.header2.copyWith(color: Colors.blue),)),

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
    required this.title,
  }) : super(key: key);

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(8),
      width: 64,
    height: 64,
    child: Center(child: Text('$title', maxLines: 2, overflow: TextOverflow.ellipsis,)),
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
