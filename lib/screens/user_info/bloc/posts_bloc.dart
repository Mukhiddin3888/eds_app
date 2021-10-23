import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app_eds/models/posts/posts_model.dart';
import 'package:test_app_eds/repositories/users_info_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial());

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    if(event is GetPosts){
      yield* _mapGetPostsToState(event.userId);
    }
  }


  Stream<PostsState> _mapGetPostsToState(int userId) async* {

    yield PostsLoading();

    try{
      final posts = await RepositoryImpl().getCurrentUserPosts(userId: userId);

      yield PostsLoaded(posts: posts);
    }
    catch (e){
      print(e);
      yield PostsError(errorMessage: e.toString());

    }

  }

}
