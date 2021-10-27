import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:test_app_eds/screens/albums/bloc/photos_bloc.dart';
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

              return Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemCount: state.photos.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                             Text('${ state.photos[index].title}', ),
                              CachedNetworkImage(imageUrl: '${state.photos[index].url}', height: 96,width: 96,),

                        ],
                      );
                    }),
              );

            }
            if(state is LoadingError){
              var lphotos =  Hive.box<List>('photos').get('photo$index')?? []  ;
              return lphotos.length > 0 ?
              Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemCount: lphotos.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${ lphotos[index].title}', ),
                          CachedNetworkImage(imageUrl: '${lphotos[index].url}', height: 96,width: 96,),

                        ],
                      );
                    }),
              )

                : ErrorButton(onTap: (){
                context.read<PhotosBloc>().add(GetPhotos(albumId: index));
              });
            }
            else return SizedBox();
          },
        ),
      ),
    );
  }
}
