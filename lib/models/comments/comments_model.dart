


import 'package:hive/hive.dart';

part 'comments_model.g.dart';

@HiveType(typeId: 6)
class CommentsModel extends HiveObject{

  @HiveField(0)
  final int postId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String body;

  CommentsModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body});


  factory CommentsModel.fromJson(Map<String, dynamic> json){
    return CommentsModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"]
    );
  }



  }