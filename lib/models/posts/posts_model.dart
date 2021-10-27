
import 'package:hive/hive.dart';

part 'posts_model.g.dart';

@HiveType(typeId: 4)
class UserPostsModel extends HiveObject {

  @HiveField(0)
  final int id;
  @HiveField(1)
  final int userId;
  @HiveField(2)
  final String title;
  @HiveField(3)
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



}