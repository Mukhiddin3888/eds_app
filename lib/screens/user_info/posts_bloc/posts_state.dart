part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}
class PostsLoading extends PostsState {}
class PostsLoaded extends PostsState {

  final List<UserPostsModel> posts;

  PostsLoaded({required this.posts});


  @override
  List<Object> get props => [posts];

}
class PostsError extends PostsState {

  final String errorMessage;
  PostsError({ required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}


