import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_app_eds/models/photos/photos_model.dart';


class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({Key? key,required this.title, required this.photos, }) : super(key: key);

  final String title;
  final List<PhotosModel> photos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$title'),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16),
    itemCount: photos.length,
    itemBuilder: (BuildContext ctx, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${photos[index].title}', ),
            CachedNetworkImage(imageUrl: '${photos[index].url}', height: 96,width: 96,),

          ],
        );
    }),
      ),
    );
  }
}
