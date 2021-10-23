
import 'package:equatable/equatable.dart';

class UserPostsModel extends Equatable {

  final int id;
  final int userId;
  final String title;
  final String body;

  UserPostsModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body
  });


  factory UserPostsModel.fromJson( Map<String, dynamic> json ){
    return UserPostsModel(
        id: json["id"],
      userId: json["userId"],
      title: json["title"],
      body: json["body"]

    );
  }


  @override
  List<Object> get props => [id,userId,title,body];

}