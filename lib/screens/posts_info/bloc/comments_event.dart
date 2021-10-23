part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();


  @override
  List<Object> get props => [];

}

class GetComment extends CommentsEvent{
  final int postId;

  GetComment({required this.postId});
}
