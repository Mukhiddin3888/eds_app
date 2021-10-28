import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:test_app_eds/screens/albums/bloc/photos_bloc.dart';
import 'package:test_app_eds/utils/styles/styles.dart';
import 'package:test_app_eds/widgets/error_button.dart';


class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({Key? key, required this.title, required this.index}) : super(key: key);

  final String title;
  final int index;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$title'),),
      body: BlocProvider(
        create: (context) => PhotosBloc(),
        child: BlocBuilder<PhotosBloc, PhotosState>(
          builder: (context, state) {

            if(state is PhotosInitial){
              context.watch<PhotosBloc>().add(GetPhotos(albumId: index ));
              return Container();
            }
            if(state is PhotosLoading){
              return Center(child: CircularProgressIndicator());
            }
            if(state is PhotosLoaded){

              return AlbumsPhotoItems(state: state.photos,);

            }
            if(state is LoadingError){
              var lphotos =  Hive.box<List>('photos').get('photo$index')?? []  ;
              return lphotos.length > 0 ?
              AlbumsPhotoItems(state: lphotos,)

                : Center(
                  child: ErrorButton(onTap: (){
                  context.read<PhotosBloc>().add(GetPhotos(albumId: index));
              }),
                );
            }
            else return SizedBox();
          },
        ),
      ),
    );
  }
}

class AlbumsPhotoItems extends StatelessWidget {
  const AlbumsPhotoItems({
    Key? key,
    required this.state
  }) : super(key: key);

  final state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 24),
          itemCount: state.length,
          itemBuilder: (BuildContext ctx, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                    CachedNetworkImage(imageUrl: '${state[index].url}', height: 110,width: 110,),
                    Text('${ state[index].title}',style: MyTextStyles.body, maxLines: 2, ),

              ],
            );
          }),
    );
  }
}
