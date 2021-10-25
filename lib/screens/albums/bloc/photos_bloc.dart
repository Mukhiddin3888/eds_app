import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app_eds/models/photos/photos_model.dart';
import 'package:test_app_eds/repositories/users_info_repository.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  PhotosBloc() : super(PhotosInitial());

  @override
  Stream<PhotosState> mapEventToState(
    PhotosEvent event,
  ) async* {
    if(event is GetPhotos){
      yield* _mapGetPhotosToState(albumId: event.albumId);
    }
  }




  Stream<PhotosState> _mapGetPhotosToState({required int albumId, }) async* {

    yield PhotosLoading();

    try{
      final photos = await RepositoryImpl().getCurrentUserAlbumsPhoto(albumId: albumId);

      yield PhotosLoaded( photos: photos);
    }
    catch (e){
      print(e);
      yield LoadingError(errorMessage: e.toString());

    }

  }


}
