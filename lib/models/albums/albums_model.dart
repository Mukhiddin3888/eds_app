import 'package:hive/hive.dart';


part 'albums_model.g.dart';

@HiveType(typeId: 5)
class AlbumsModel extends HiveObject {

  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;

  AlbumsModel({
    required this.userId,
    required this.id,
    required this.title});

  factory AlbumsModel.fromJson(Map<String, dynamic> json){
    return AlbumsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"]
    );
  }



}