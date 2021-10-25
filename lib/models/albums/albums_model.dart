import 'package:equatable/equatable.dart';

class AlbumsModel extends Equatable {


  final int userId;
  final int id;
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



  @override
  List<Object> get props => [userId,id,title];
}