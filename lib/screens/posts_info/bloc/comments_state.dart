part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();
  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {

}

class CommentsLoading extends CommentsState {}
class CommentsLoaded extends CommentsState {

  final List<CommentsModel> comments;

  CommentsLoaded(this.comments);



  @override
  List<Object> get props => [comments];

}
class LoadingError extends CommentsState {

  final String errorMessage;
  LoadingError({ required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}
