import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app_eds/models/comments/comments_model.dart';
import 'package:test_app_eds/repositories/users_info_repository.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsInitial());

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    if(event is GetComment){
      yield* _mapGetCommentsToState(postId: event.postId);
    }

  }

  Stream<CommentsState> _mapGetCommentsToState({required int postId}) async* {

    yield CommentsLoading();

    try{
      final comments = await RepositoryImpl().getCurrentUserPostsComments(postId: postId);

      yield CommentsLoaded(comments);
    }
    catch (e){
      print(e);
      yield LoadingError(errorMessage: e.toString());

    }

  }

}
