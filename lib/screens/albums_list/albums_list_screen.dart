import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_eds/models/albums/albums_model.dart';
import 'package:test_app_eds/models/photos/photos_model.dart';
import 'package:test_app_eds/screens/albums/albums_screen.dart';

class AlbumsListScreen extends StatelessWidget {
  const AlbumsListScreen({Key? key,
    required this.userName,
    required this.photos,
    required this.albums}) : super(key: key);

  final String userName;
  final List<AlbumsModel> albums;
  final List<PhotosModel> photos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$userName's albums"),),
      body: ListView.builder(
        itemCount: albums.length,
          itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, CupertinoPageRoute(
              builder: (context) => AlbumsScreen(title: albums[index].title, photos: photos,),));
          },
          child: ListTile(
            trailing: Icon(Icons.keyboard_arrow_right),
            leading: CircleAvatar(),
            title:  Text('${albums[index].title}'),),
        );
      },
      ),
    );
  }
}
