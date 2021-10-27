import 'package:hive/hive.dart';


part 'photos_model.g.dart';

@HiveType(typeId: 7)
class PhotosModel extends HiveObject {

  @HiveField(0)
  final int albumId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String thumbnailUrl;

  PhotosModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,

  });

  factory PhotosModel.fromJson(Map<String, dynamic> json){
    return PhotosModel(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"]
    );
  }



}